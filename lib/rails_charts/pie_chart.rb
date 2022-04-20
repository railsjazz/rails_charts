module RailsCharts
  class PieChart < LineChart
    attr_reader :radius, :emphasis
    
    def initialize(data, options = {})
      super(data, options)

      @emphasis = options.delete(:emphasis)
      @radius   = options.delete(:radius) || '50%'
    end

    def type
      'pie'
    end

    def build_options
      super.except(:xAxis, :yAxis)
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