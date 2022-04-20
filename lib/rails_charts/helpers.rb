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

    def radar_chart(data, options = {})
      generate_rails_chart RadarChart, data, options
    end    

    def generate_rails_chart(klass, data, options = {})
      klass = klass.new(data, options)
      if options[:code]
        tag.textarea(row: 20, cols: 80, style: 'width: 100%; height: 300px') do
          klass.js_code
        end
      else
        raw klass.js_code
      end
    end

  end
end
