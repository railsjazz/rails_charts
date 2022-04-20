module RailsCharts
  class LineChart < BaseChart
    attr_reader :smooth

    def initialize(data, options = {})
      super(data, options)
      @smooth = options.delete(:smooth)
    end

    def type
      'line'
    end

    def generate_series_options
      if data.is_a?(Array)
        data.map do |e|
          {
            data: e[:data].values,
            type: type,
            name: e[:name].to_s,
            smooth: self.smooth,
          }
        end
      else
        {
          data: data.values,
          type: type,
          name: y_title.to_s,
          smooth: self.smooth,
        }
      end
    end

    def generate_x_axis_options
      {
        name: self.x_title,
        type: 'category',
        data: x_axis_data(data)
      }
    end

    def generate_y_axis_options
      {
        type: 'value',
        name: self.y_title,
      }
    end
  end
end