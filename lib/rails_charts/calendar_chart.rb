module RailsCharts
  class CalendarChart < BaseChart
    attr_reader :visual_map_options
    
    def initialize(data, options = {})
      super(data, options)
    end

    def type
      'heatmap'
    end

    def build_options
      super.except(:xAxis, :yAxis)
    end

    def generate_series_options
      {
        type: type,
        coordinateSystem: 'calendar',
        data: data[:data]
      }
    end

    def defaults
      {
        tooltip: {
          item: {
            trigger: 'item',
          },
        },
      }
    end
  
  end  
end