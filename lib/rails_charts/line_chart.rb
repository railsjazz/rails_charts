module RailsCharts
  class LineChart < BaseChart

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
          }
        end
      else
        {
          data: data.values,
          type: type,
        }
      end
    end

    def generate_x_axis_options
      {
        type: 'category',
        data: x_axis_data(data)
      }
    end

    def generate_y_axis_options
      {
        type: 'value',
      }
    end

    private

    def x_axis_data(data)
      if data.is_a?(Array)
        data.map{|e| e[:data].keys}.uniq.flatten
      else
        data.keys
      end
    end    
  end
end