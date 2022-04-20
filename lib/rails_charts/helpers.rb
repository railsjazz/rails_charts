require "json"
require "erb"

module RailsCharts
  module Helpers

    def line_chart(data, **options)
      klass = LineChart.new(data, options)
      pp klass.options
      raw klass.js_code
    end

    def bar_chart(data, **options)
      klass = BarChart.new(data, options)
      pp klass.options
      raw klass.js_code
    end

  end
end
