module RailsCharts
  class StackedBarChart < BarChart

    def defaults
      super.deep_merge({
        series: {
          stack: 'stack',
        },
      })
    end
  
  end
end