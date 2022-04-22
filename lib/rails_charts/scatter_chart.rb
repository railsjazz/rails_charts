module RailsCharts
  class ScatterChart < LineChart

    def type
      'scatter'
    end

    # def generate_series_options
    #   {
    #     data: data,
    #     type: type,
    #   }
    # end

    def defaults
      {
        xAxis: {},
        yAxis: {},
        tooltip: {
          formatter: '{c}'
        },
      }
    end

    def x_axis
      {}
    end

    def y_axis
      {}
    end    
  
  end  
end