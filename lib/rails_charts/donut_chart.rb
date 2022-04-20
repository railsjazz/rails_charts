module RailsCharts
  class DonutChart < PieChart

    def initialize(data, options = {})
      super(data, options)
      @radius   = options.delete(:radius) || ['40%', '70%']
    end

    def generate_series_options
      {
        data: data.map{|k, v| {name: k, value: v} },
        type: type,
        radius: radius,
        emphasis: emphasis
      }
    end
  
  end  
end