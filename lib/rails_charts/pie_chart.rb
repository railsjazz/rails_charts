module RailsCharts
  class PieChart < LineChart

    def type
      'pie'
    end

    def build_options
      super.except(:xAxis, :yAxis)
    end

    def generate_series_options
      if data[0].is_a?(Hash)
        {
          data: data,
          type: type
        }
      else
        {
          data: data.map{|k, v| {name: k, value: v} },
          type: type
        }
      end
    end

    def x_axis
      []
    end

    def y_axis
      []
    end    

    def defaults
      {
        tooltip: {
          item: {
            trigger: 'item',
          },      
        },
        series: {
          radius: '70%',
        },
        emphasis: {
          itemStyle: {
            shadowBlur: 10,
            shadowOffsetX: 0,
            shadowColor: 'rgba(0, 0, 0, 0.5)'
          }
        }
      }
    end
  
  end  
end