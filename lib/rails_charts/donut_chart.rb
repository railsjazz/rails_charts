module RailsCharts
  class DonutChart < PieChart

    def initialize(data, options = {})
      super(data, options)
    end

    def generate_series_options
      {
        data: data.map{|k, v| {name: k, value: v} },
        type: type
      }
    end

    def defaults
      {
        tooltip: {
          item: {
            trigger: 'item',
          },
        }, 
        series: {
          radius: ['40%', '70%']
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