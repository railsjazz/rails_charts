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
        toolbox: {
          feature: {
            saveAsImage: {}
          },
        }
      }
    end

    def x_axis
      return super if data[0].is_a?(Hash)

      {
        type: 'category'
      }
    end

    private

    def series_defaults
      {
        areaStyle: {},
        stack: 'Total'
      }
    end

  end
end
