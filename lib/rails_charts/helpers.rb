require "json"
require "erb"

module RailsCharts
  module Helpers

    def line_chart(data, options = {})
      generate_rails_chart LineChart, data, options
    end

    def bar_chart(data, options = {})
      generate_rails_chart BarChart, data, options
    end

    def pie_chart(data, options = {})
      generate_rails_chart PieChart, data, options
    end

    def donut_chart(data, options = {})
      generate_rails_chart DonutChart, data, options
    end

    def area_chart(data, options = {})
      generate_rails_chart AreaChart, data, options
    end

    def generate_rails_chart(klass, data, options = {})
      klass = klass.new(data, options)
      puts klass.js_code
      raw klass.js_code
    end

  end
end
