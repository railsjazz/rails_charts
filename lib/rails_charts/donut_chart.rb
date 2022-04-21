module RailsCharts
  class DonutChart < PieChart

    def initialize(data, options = {})
      super(data, options)
    end

    def generate_series_options
      {
        data: data.map{|k, v| {name: k, value: v} },
        type: type,
        emphasis: emphasis
      }
    end
  
  end  
end