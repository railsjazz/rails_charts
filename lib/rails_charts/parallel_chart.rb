module RailsCharts
  class ParallelChart < BaseChart

    def type
      'parallel'
    end

    def build_options
      super.except(:xAxis, :yAxis)
    end    

    def generate_series_options
      {
        data: data,
        type: type
      }
    end

    def defaults
      {
        series: {
          lineStyle: {
            width: 2
          }
        }
      }
    end
  
  end  
end