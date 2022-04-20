module RailsCharts
  class RadarChart < BaseChart
    attr_reader :radar_options
    
    def initialize(data, options = {})
      super(data, options)

      @radar_options = options.delete(:radar_options)
    end

    def type
      'radar'
    end

    def build_options
      super.except(:xAxis, :yAxis).merge(radar)
    end

    def radar
      {
        radar: {
          indicator: data[:indicators].map{|(k, v)| {name: k, value: v} }
        }
      }
    end

    def generate_series_options
      {
        type: type,
        data: data[:data]
      }
    end
  
  end  
end