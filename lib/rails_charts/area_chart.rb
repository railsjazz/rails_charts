module RailsCharts
  class AreaChart < LineChart

    def defaults
      {
        tooltip: {
          trigger: 'axis'
        },      
        xAxis: {
          boundaryGap: false
        },
        series: {
          areaStyle: {},
          stack: 'Total'
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