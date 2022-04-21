module RailsCharts
  class GaugeChart < BaseChart

    def type
      'gauge'
    end

    def build_options
      super.except(:xAxis, :yAxis)
    end    

    def generate_series_options
      {
        data: Array.wrap(data[:data]),
        type: type,
      }
    end
  
  end  
end