module RailsCharts
  class BaseChart
    CHART_JS_PATTERN = /"RAILS_CHART_JS:((?!RAILS_CHART_JS:).*?):RAILS_CHART_JS_END"/

    using RubyExt

    attr_reader :data, :options, :chart_id, :container_id, :defaults
    attr_reader :width, :height, :style, :klass, :theme, :locale, :renderer
    attr_reader :other_options, :debug
    attr_reader :vertical

    def initialize(data, options = {})
      @data          = data
      @options       = options
      @other_options = options.delete(:options).presence || {}
      @defaults      = RailsCharts.defaults[self.class].presence || {}

      @chart_id      = "rails_charts_#{Digest::SHA1.hexdigest([Time.now, rand].join)}"
      @container_id  = options.delete(:id).presence || @chart_id

      @width         = options.delete(:width).presence || RailsCharts.options[:width]
      @height        = options.delete(:height).presence || RailsCharts.options[:height]
      @theme         = options.delete(:theme).presence || RailsCharts.options[:theme]
      @locale        = options.delete(:locale).presence || RailsCharts.options[:locale]
      @renderer      = options.delete(:renderer).presence || RailsCharts.options[:renderer] || "canvas"
      @klass         = options.delete(:class).presence || RailsCharts.options[:class]
      @style         = options.delete(:style).presence || RailsCharts.options[:style]

      @debug         = options.delete(:debug)

      @vertical      = options.delete(:vertical).presence
    end

    def js_code
      style_css = []
      style_css << "width: #{width}" if width
      style_css << "height: #{height}" if height
      style_css << style

      %Q{
        <div id="#{container_id}" class="#{klass}" style="#{style_css.compact.join('; ')}">
          <script>
            if (!window.RailsCharts) {
              window.RailsCharts = {}
              window.RailsCharts.charts = {}
            }

            function init_#{chart_id}(e) {
              if (document.documentElement.hasAttribute("data-turbolinks-preview")) return;
              if (document.documentElement.hasAttribute("data-turbo-preview")) return;

              <!-- #{self.class} -->
              var chartDom = document.getElementById('#{container_id}');

              if (!chartDom) { return }

              var lib = ("echarts" in window) ? window.echarts : echarts;
              var chart = lib.init(chartDom, #{theme.to_json}, { "locale": #{locale.to_json}, "renderer": #{renderer.to_json} });
              var option = #{option};
              option && chart.setOption(option);

              window.RailsCharts.charts["#{container_id}"] = chart;

              chart.on('rendered', function() {
                document.dispatchEvent(new CustomEvent('chart:rendered', {
                  detail: { containerId: '#{container_id}' }
                }));
              });
            }

            function destroy_#{chart_id}(e) {
              var chart = window.RailsCharts.charts["#{container_id}"];
              if (chart) {
                chart.dispose()
              }
              delete window.RailsCharts.charts["#{container_id}"];
            }

            window.addEventListener('load', init_#{chart_id});
            window.addEventListener('turbo:load', init_#{chart_id});
            window.addEventListener('turbolinks:load', init_#{chart_id});

            window.addEventListener('turbo:frame-render', init_#{chart_id});
            window.addEventListener('turbo:frame-load', ()=> {
                window.removeEventListener('turbo:frame-render', init_#{chart_id});
            });

            document.addEventListener("turbolinks:before-render", destroy_#{chart_id});
            document.addEventListener("turbo:before-render", destroy_#{chart_id});
          </script>
        </div>
      }
    end

    def option
      str = build_options.to_json
      str.gsub!(CHART_JS_PATTERN) { Base64.decode64($1).force_encoding(Encoding::UTF_8) }
      str
    end

    def build_options
      hash = {}

      hash[:series] = Array.wrap(generate_series_options)

      hash = hash.complex_merge(axises)
      hash = hash.complex_merge(defaults)
      hash = hash.complex_merge(other_options)

      hash
    end

    def axises
      if self.vertical
        {
          xAxis: y_axis,
          yAxis: x_axis,
        }
      else
        {
          xAxis: x_axis,
          yAxis: y_axis,
        }
      end
    end

    def x_axis
      []
    end

    def y_axis
      []
    end

  end
end
