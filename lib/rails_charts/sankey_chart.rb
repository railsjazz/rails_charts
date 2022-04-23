module RailsCharts
  class SankeyChart < BaseChart

    def type
      'sankey'
    end

    def build_options
      super.except(:xAxis, :yAxis)
    end    

    def generate_series_options
      {
        data: data[:data],
        links: data[:links],
        type: type
      }
    end

    def defaults
      {
        series: {
          emphasis: {
            focus: 'adjacency'
          }
        }
      }
    end
  
  end  
end