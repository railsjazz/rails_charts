module RailsCharts
  class CalendarChart < BaseChart
    attr_reader :visual_map_options, :calendar_options
    
    def initialize(data, options = {})
      super(data, options)

      @visual_map_options = options.delete(:visual_map_options)
      @calendar_options = options.delete(:calendar_options)
    end

    def type
      'heatmap'
    end

    def build_options
      super.except(:xAxis, :yAxis).merge(visual_map).merge(calendar)
    end

    def visual_map
      { 
        visualMap: {
          min: 0,
          max: 50,
          type: 'piecewise',
          orient: 'horizontal',
          left: 'center',
          top: 65
        }
      }
    end

    def calendar
      {
        calendar: {
          top: 120,
          left: 30,
          right: 30,
          cellSize: 15,
          range: '2021',
          itemStyle: {
            borderWidth: 0.5
          }
        }
      }
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