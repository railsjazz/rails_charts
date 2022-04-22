module RailsCharts
  class BarChart < LineChart
    
    def type
      'bar'
    end

    def defaults
      {
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            type: 'shadow'
          }        
        },
        toolbox: {
          feature: {
            saveAsImage: {}
          },
        }     
      }
    end
  
  end
end