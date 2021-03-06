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

    def stacked_bar_chart(data, options = {})
      generate_rails_chart StackedBarChart, data, options
    end    

    def pie_chart(data, options = {})
      generate_rails_chart PieChart, data, options
    end

    def scatter_chart(data, options = {})
      generate_rails_chart ScatterChart, data, options
    end

    def parallel_chart(data, options = {})
      generate_rails_chart ParallelChart, data, options
    end    

    def donut_chart(data, options = {})
      generate_rails_chart DonutChart, data, options
    end

    def sankey_chart(data, options = {})
      generate_rails_chart SankeyChart, data, options
    end

    def area_chart(data, options = {})
      generate_rails_chart AreaChart, data, options
    end

    def radar_chart(data, options = {})
      generate_rails_chart RadarChart, data, options
    end  
    
    def calendar_chart(data, options = {})
      generate_rails_chart CalendarChart, data, options
    end

    def funnel_chart(data, options = {})
      generate_rails_chart FunnelChart, data, options
    end

    def gauge_chart(data, options = {})
      generate_rails_chart GaugeChart, data, options
    end

    def candlestick_chart(data, options = {})
      generate_rails_chart CandlestickChart, data, options
    end    

    def custom_chart(options = {})
      generate_rails_chart CustomChart, [], options
    end

    def generate_rails_chart(klass, data, options = {})
      klass = klass.new(data, options)
      if options[:code]
        tag.textarea(row: 20, cols: 80, style: 'width: 100%; height: 300px') do
          klass.js_code
        end
      else
        # tag.pre(debug(data.inspect)) +
        # tag.textarea(row: 20, cols: 80, style: 'width: 100%; height: 300px') do
        #   klass.js_code
        # end +
        raw(klass.js_code)
      end
    end

  end
end
