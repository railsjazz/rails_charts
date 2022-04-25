module RailsCharts
  class CandlestickChart < LineChart
    
    def type
      'candlestick'
    end

    def defaults
      {
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            type: 'cross'
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