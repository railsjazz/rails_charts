# Rails Charts

One more gem to build nice charts for your Ruby on Rails application.

It contains useful helpers to build various types of charts of use custom option to build very complex charts using Apache eCharts library.

What you can build with it:

- area char
- bar chart
- calendar chart
- candlestick chart
- funnel chart
- gauge chart
- line chart
- parallel chart
- donut chart
- pie chart
- radar chart
- sankey chart
- scatter chart
- stacked bar chart
- custom chart

In most cases with one line of code you can have a nice chart. The idea of this gem was inspired by [Charkick](https://github.com/ankane/chartkick) gem which is great and allows you to build charts very quickly. It works the best with cooperation of [groupdate](https://github.com/ankane/groupdate) gem.

But this implementation have more customization options (thanks to more Apache eCharts).

## Usage

1) add gem in Gemfile, `gem "rails_charts"`
2) add JS, for example in `application.js`

```
//= require rails_charts/echarts.min.js
//= require rails_charts/theme/vintage.js
```

Note you can specify different themes.

3) add your first chart `<%= line_chart User.group(:age).count %>`
4) customize charts if needed. See available options or [official documentation](https://echarts.apache.org/examples/en/index.html). 

## Installation

Add this line to your application's Gemfile:

```ruby
gem "rails_charts"
```

And then execute:
```bash
$ bundle
```

## Contributing

You are welcome to contributes. Some open tasks:

- importmaps support?
- webpacker support
- add more specs
- add more examples to the dummy app
- customization, options overides, default values?

### Development and testing

`test/dummy/bin/rails s` - to start dummy app.

`rspec` - to run specs.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

Gem is using https://echarts.apache.org/ to build charts.
