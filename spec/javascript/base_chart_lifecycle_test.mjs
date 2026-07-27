import assert from 'node:assert/strict';
import { execFileSync } from 'node:child_process';
import vm from 'node:vm';

const html = execFileSync(
  'bundle',
  [
    'exec',
    'ruby',
    '-Ilib',
    '-e',
    'require "rails"; require "rails_charts"; puts RailsCharts::LineChart.new({"Monday" => 1}, id: "lifecycle-chart").js_code',
  ],
  { encoding: 'utf8' },
);
const script = html.match(/<script>([\s\S]*)<\/script>/)?.[1];
assert.ok(script, 'generated chart HTML includes a script');

class FakeEventTarget {
  constructor() {
    this.listeners = new Map();
  }

  addEventListener(name, callback, options = {}) {
    const listeners = this.listeners.get(name) || new Set();
    listeners.add(callback);
    this.listeners.set(name, listeners);

    options.signal?.addEventListener(
      'abort',
      () => this.removeEventListener(name, callback),
      { once: true },
    );
  }

  removeEventListener(name, callback) {
    this.listeners.get(name)?.delete(callback);
  }

  dispatch(name, target = this) {
    for (const callback of [...(this.listeners.get(name) || [])]) {
      callback({ target });
    }
  }

  listenerCount(name) {
    return this.listeners.get(name)?.size || 0;
  }
}

let chartElement = {};
const containingFrame = { contains: (element) => element === chartElement };
const unrelatedFrame = { contains: () => false };
const browserWindow = new FakeEventTarget();
const browserDocument = new FakeEventTarget();
browserDocument.documentElement = { hasAttribute: () => false };
browserDocument.getElementById = (id) => (id === 'lifecycle-chart' ? chartElement : null);

const instances = new WeakMap();
let initializationCount = 0;
let disposalCount = 0;

browserWindow.echarts = {
  getInstanceByDom: (element) => instances.get(element),
  init: (element) => {
    initializationCount += 1;

    const chart = {
      setOption: () => {},
      on: () => {},
      dispose: () => {
        disposalCount += 1;
        instances.delete(element);
      },
    };

    instances.set(element, chart);
    return chart;
  },
};

globalThis.window = browserWindow;
globalThis.document = browserDocument;

const evaluateGeneratedScript = () => vm.runInThisContext(script);

evaluateGeneratedScript();
browserWindow.dispatch('load');
assert.equal(initializationCount, 1, 'the first load initializes the chart');

browserWindow.dispatch('turbo:load');
assert.equal(initializationCount, 1, 'later load events reuse the existing chart instance');

evaluateGeneratedScript();
assert.equal(browserWindow.listenerCount('turbo:load'), 1, 'reevaluation replaces stale listeners');
browserWindow.dispatch('turbo:load');
assert.equal(initializationCount, 1, 'reevaluation reuses the existing chart instance');

browserDocument.dispatch('turbo:before-frame-render', unrelatedFrame);
browserDocument.dispatch('turbo:frame-render', unrelatedFrame);
assert.equal(disposalCount, 0, 'unrelated frame events leave the chart alone');
assert.equal(initializationCount, 1, 'unrelated frame events do not initialize the chart');

browserDocument.dispatch('turbo:before-frame-render', containingFrame);
assert.equal(disposalCount, 1, 'replacing the containing frame disposes the chart');
assert.equal(browserWindow.RailsCharts.charts['lifecycle-chart'], undefined);
assert.equal(browserWindow.RailsCharts.listenerControllers['lifecycle-chart'], undefined);

browserWindow.dispatch('load');
assert.equal(initializationCount, 1, 'disposed chart listeners no longer respond');

chartElement = {};
evaluateGeneratedScript();
browserDocument.dispatch('turbo:frame-render', containingFrame);
assert.equal(initializationCount, 2, 'the replacement frame initializes a fresh chart');

browserDocument.dispatch('turbo:before-cache');
assert.equal(disposalCount, 2, 'caching a page disposes the active chart');

browserWindow.dispatch('turbo:load');
assert.equal(initializationCount, 2, 'page-cache disposal also removes stale listeners');
