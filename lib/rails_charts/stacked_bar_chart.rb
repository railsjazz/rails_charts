module RailsCharts
  class StackedBarChart < BarChart

    private

    def series_defaults
      {
        stack: 'stack',
      }
    end
  
  end
end
