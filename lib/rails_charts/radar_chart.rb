module RailsCharts
  class RadarChart < BaseChart

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