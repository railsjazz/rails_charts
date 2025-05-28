# Rails Charts

[![RailsJazz](https://github.com/igorkasyanchuk/rails_time_travel/blob/main/docs/my_other.svg?raw=true)](https://www.railsjazz.com)

[!["Buy Me A Coffee"](https://github.com/igorkasyanchuk/get-smart/blob/main/docs/snapshot-bmc-button-small.png?raw=true)](https://buymeacoffee.com/igorkasyanchuk)

![Charts](docs/all.jpg)

One more gem to build nice charts for your Ruby on Rails application.

With it you can build various types of charts [Apache eCharts](https://echarts.apache.org/) library (v. 5.4.0). This gem simplifies interface and adding few helpers to start adding charts in your app with just a few lines of code.

What you can build with it:

- [area chart](#area-chart)
- [line chart](#line-chart)
- [bar chart](#bar-chart)
- [donut chart](#donut-chart)
- [pie chart](#pie-chart)
- [radar chart](#radar-chart)
- [calendar chart](#calendar-chart)
- [candlestick chart](#candlestick-chart)
- [funnel chart](#funnel-chart)
- [gauge chart](#gauge-chart)
- [parallel chart](#parallel-chart)
- [sankey chart](#sankey-chart)
- [scatter chart](#scatter-chart)
- [stacked bar chart](#stacked-bar-chart)
- [custom chart](#custom-chart)

In most cases with one line of code you can have a nice chart. The idea of this gem was inspired by [Chartkick](https://github.com/ankane/chartkick) gem which is great and allows you to build charts very quickly. It works best in cooperation with [groupdate](https://github.com/ankane/groupdate) gem. Unfortunatelly it's missing many needed types of charts or other customization options.

This implementation have more options and similar "interface" for building charts.


## Installation

Add gem to your application's Gemfile:

```ruby
gem "rails_charts"
```

Then execute:
```bash
$ ./bin/bundle install
```

You can install ECharts with installation command

```bash
$ ./bin/rails rails_charts:install
```

or do it manualy

### Sprockets

1) add eCharts in main JS bundle, e.g. `app/assets/javascripts/application.js`

```javascript
//= require echarts.min.js
//= require echarts/theme/dark.js
```

3) add your first chart e.g.
```ruby
<%= line_chart User.group(:age).count %>
```

4) customize charts if needed. See available options or [official documentation](https://echarts.apache.org/examples/en/index.html).


### Webpack / esbuild

1) Run:

```bash
yarn add echarts
```

#### For Rails 7
2) In `app/javascript/application.js` add this:

```javascript
import * as echarts from 'echarts';
import 'echarts/theme/dark';

window.echarts = echarts;
```

#### For Rails 6
2) In `app/javascript/packs/application.js` add this:

```javascript
import * as echarts from 'echarts';
import 'echarts/theme/dark';

window.echarts = echarts;
```

3) add your first chart e.g.
```ruby
<%= line_chart User.group(:age).count %>
```

4) customize charts if needed. See available options or [official documentation](https://echarts.apache.org/examples/en/index.html).

### Importmaps

1) change `config/importmap.rb`

```ruby
pin "echarts", to: "echarts.min.js"
pin "echarts/theme/dark", to: "echarts/theme/dark.js"
```

2) add eCharts in main JS

```javascript
import "echarts"
import "echarts/theme/dark"
```

3) add your first chart e.g.
```ruby
<%= line_chart User.group(:age).count %>
```

4) customize charts if needed. See available options or [official documentation](https://echarts.apache.org/examples/en/index.html).

## Options

```ruby
<%= line_chart data, {
  width: '250px',
  height: '250px',
  theme: 'dark',
  class: 'chart-container-class',
  style: 'padding: 10px'
} %>
```

Available options:

```yaml
width: specify width of the chart
height: specify height of the chart
theme: specify theme of the chart (available themes examples https://echarts.apache.org/en/download-theme.html)
class: specify container's CSS class
id: specify container's ID
style: add inline style
debug: for gem development useful if you want to pause somewhere in the code
vertical: applicable for some types of charts
code: to see output code what is generated to see the chart, useful for debugging
options: {...}, nested hash, specify additional eCharts options
```

Apache eCharts options - https://echarts.apache.org/en/option.html#title.

If you need to format tooltip (or other javascript function as an option) you can pass a JS function, but you need to wrap it like:

```ruby
  options: {
    tooltip: {
      valueFormatter: RailsCharts.js("(value) => '$' + Math.round(value)")
    }
  }
```

## Charts

All examples available in https://github.com/railsjazz/rails_charts/tree/main/test/dummy/app/views/home. You can see more examples if you clone this repo and start a dummy app.

Every chart has a built in default configuration for tooltips, or other options (sample https://github.com/railsjazz/rails_charts/blob/main/lib/rails_charts/line_chart.rb#L64-L75). This is just to simplify usage of this gem. In the future the plan is to have it configured in initializer.

### Area Chart

![Area Chart](docs/area_chart.png)

```ruby
<%= area_chart User.distinct.pluck(:role).map{|e| {name: e, data: User.where(role: e).group_by_day(:created_at).count} } %>
```

### Line Chart

![Line Chart](docs/line_chart.png)

```ruby
<%= line_chart User.group(:age).count, class: 'box',
  options: {
    title: {
      text: "People count by age",
      left: 'center'
    },
  }
%>
```

### Bar Chart

![Bar Chart](docs/bar_chart.png)

```ruby
<%= bar_chart User.group(:role).average(:age),
  class: 'box',
  theme: 'sakura',
  options: {
    series: {
      barWidth: '50%'
    },
    tooltip: {
      valueFormatter: RailsCharts.js("(value) => '$' + Math.round(value)")
    }
  }
%>
```

### Calendar Chart

![Calendar Chart](docs/calendar_chart.png)

```ruby
<%= calendar_chart Commit.for_calendar_chart,
  class: 'box',
  options: {
    visualMap: {
      show: true,
      min: 0,
      max: 40,
      orient: 'horizontal'
    },
    calendar: [{
      range: '2021',
    },]
  }
%>

```

### Candlestick Chart

![Candlestick Chart](docs/candlestick_chart.png)

```ruby
<%= candlestick_chart({
    '2017-10-24' => [20, 34, 10, 38],
    '2017-10-25' => [40, 35, 30, 50],
    '2017-10-26' => [31, 38, 33, 44],
    '2017-10-27' => [38, 15, 5, 42]
  },
  class: 'box',
  theme: 'roma',
  options: {
    xAxis: {
      axisTick: {
        alignWithLabel: true
      }
    }
  })
%>
```

### Funnel Chart

![Funnel Chart](docs/funnel_chart.png)

```ruby
<%= funnel_chart User.get_funnel_sample_data,
  class: 'box',
  height: '400px',
  options: {
    title: {
      text: 'Demo',
      left: 'center'
    }
  }
%>
```

### Gauge Chart

![Gauge Chart](docs/gauge_chart.png)

```ruby
<%= gauge_chart User.get_gauge_sample_data,
  class: 'box',
  height: '400px',
  options: {
    title: {
      text: 'Demo',
      left: 'center'
    }
  }
%>
```

### Parallel Chart

![Parallel Chart](docs/parallel_chart.png)

```ruby
<div class="box">
  <%= parallel_chart [
    [1, 2, 1, "Ruby"],
    [2, 3, 2, "JavaScript"],
    [3, 1, 3, "C#"]
  ], {
    options: {
      parallelAxis: [
        { dim: 0, name: '2019', inverse: true, minInterval: 1, min: 1, nameTextStyle: { fontSize: 16 }, axisLabel: { fontSize: 16 } },
        { dim: 1, name: '2020', inverse: true, minInterval: 1, min: 1, nameTextStyle: { fontSize: 16 }, axisLabel: { fontSize: 16 } },
        { dim: 2, name: '2021', inverse: true, minInterval: 1, min: 1, nameTextStyle: { fontSize: 16 }, axisLabel: { fontSize: 16 } },
        { dim: 3, type: "category", name: 'Language', data: ["Ruby", "JavaScript", "C#"], inverse: true, nameTextStyle: { fontSize: 16 }, axisLabel: { fontSize: 14 } },
      ]
    }
  }
  %>
</div>
```

### Donut Chart

![Donut Chart](docs/donut_chart.png)

```ruby
<%= donut_chart User.group(:role).count,
  class: 'box',
  options: {
    legend: {
      bottom: '0'
    },
    emphasis: {
      itemStyle: {
        shadowBlur: 10,
        shadowOffsetX: 0,
        shadowColor: 'rgba(0, 0, 0, 0.5)'
      }
    }
  }
%>
```

### Pie Chart

![Pie Chart](docs/pie_chart.png)

```ruby
<%= pie_chart User.group(:role).count,
  class: 'box',
  options: {
    legend: { orient: 'vertical', left: 'left' }
  }
%>
```

### Radar Chart

![Radar Chart](docs/radar_chart.png)

```ruby
<%= radar_chart User.get_data_for_radar_chart,
  class: 'box',
  options: {
    legend: {
      data: ['Average Salaries', 'Maximum Salary'],
      orient: 'vertical',
      left: '20%'
    }
  }
%>
```

### Sankey Chart

![Sankey Chart](docs/sankey_chart.png)

```ruby
<%= sankey_chart({
    data: [
      {name: 'Ruby'}, {name: 'HTML'}, {name: 'JS'}, {name: 'Good'}, {name: 'Bad'}, {name: 'CSS'}, {name: 'PHP'}, {name: 'Frontend'}, {name: 'Backend'}
    ],
    links: [
      {
        source: 'Ruby',
        target: 'Good',
        value: 1
      },
      {
        source: 'HTML',
        target: 'Good',
        value: 1
      },
      {
        source: 'JS',
        target: 'Good',
        value: 1
      },
      {
        source: 'CSS',
        target: 'Good',
        value: 1
      },
      {
        source: 'PHP',
        target: 'Bad',
        value: 1
      },
      {
        source: 'Good',
        target: 'Backend',
        value: 1
      },
      {
        source: 'Good',
        target: 'Frontend',
        value: 3
      },
      {
        source: 'Bad',
        target: 'Backend',
        value: 1
      },
    ]
  }, {
    options: {

    }
  })
  %>
```

### Scatter Chart

![Scatter Chart](docs/scatter_chart.png)

```ruby
<%= scatter_chart [
    { name: 'John', data: User.random_scatter_chart(500, 200) },
    { name: 'Bob', data: User.random_scatter_chart(500, 1000) },
  ],
  {
    class: 'box',
    options: {
      xAxis: {
        name: 'Distance'
      },
      yAxis: {
        name: 'Sales'
      },
      legend: {
        data: [
          {name: 'John'},
          {name: 'Bob'},
        ]
      },
    },
  }
%>
```

### Stacked bar Chart

![Stacked bar Chart](docs/stacked_bar_chart.png)

```ruby
<%= stacked_bar_chart [
    { name: 'high priority', data: Account.group_by_month(:created_at, format: "%b %Y").count },
    { name: 'low priority', data: Account.group_by_month(:created_at, format: "%b %Y").count }
  ],
  {
    options: {
      title: {
        text: "Popular vs Unpopular"
      },
    },
    class: 'box',
    vertical: true
  }
%>
```

### Custom Chart

![Custom Chart](docs/custom_chart.png)

```ruby
<%= custom_chart {...raw JS options ...} %>
```

## Contributing

You are welcome to contributes. Some open tasks:

- support turbo streams?
- add more specs
- add more examples to the dummy app
- customization, options overides, default values?
- every "5sec" refresh
- remote data
- how to access chart from JS
- better documentation how to specify theme, locale, etc
- more examples with data structure
- add github actions
- add info about initializer and it's configuration
- specify info about default configs per chart
- add support for CSP similar to https://github.com/ankane/chartkick/blob/master/lib/chartkick/helper.rb#L55
- example of how to build multiple-chart charts

### How to upgrade eCharts

- download ZIP file
- unpack it
- replace files in `app/assets/javascripts/echarts.min.js` and other related files inside echarts folder (from root folder of unpacked ZIP file).

### Development and testing

`test/dummy/bin/rails s` - to start dummy app.

`rspec` - to run specs.

Prepare test data:

`rails c`

```ruby
Data.populate
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

Gem is using https://echarts.apache.org/ to build charts.

[<img src="https://github.com/igorkasyanchuk/rails_time_travel/blob/main/docs/more_gems.png?raw=true"
/>](https://www.railsjazz.com/?utm_source=github&utm_medium=bottom&utm_campaign=rails_charts)

[!["Buy Me A Coffee"](https://github.com/igorkasyanchuk/get-smart/blob/main/docs/snapshot-bmc-button.png?raw=true)](https://buymeacoffee.com/igorkasyanchuk)
