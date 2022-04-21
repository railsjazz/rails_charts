module RailsCharts
  class PieChart < LineChart

    def type
      'pie'
    end

    def build_options
      super.except(:xAxis, :yAxis)
    end

    def generate_series_options
      {
        data: data.map{|k, v| {name: k, value: v} },
        type: type
      }
    end
  
  end  
end