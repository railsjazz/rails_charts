module RailsCharts
  class FunnelChart < BaseChart

    def type
      'funnel'
    end

    def build_options
      super.except(:xAxis, :yAxis)
    end    

    def generate_series_options
      {
        data: data[:data],
        type: type,
      }
    end
  
  end  
end