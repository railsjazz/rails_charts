module RailsCharts
  class LineChart < BaseChart

    def initialize(data, options = {})
      super(Array.wrap(data.to_a), options)
    end

    def type
      'line'
    end

    def x
      case data[0]
      when Array
        data.map{|e| e[0]}
      when Hash
        data.map{|e| e[:data].keys}.flatten
      else
        nil
      end&.uniq
    end

    def y
      case data[0]
      when Array
        data.map{|e| e[1]}
      when Hash
        data.map{|e| e[:name]}
      end
    end    

    def generate_series_options
      binding.pry if debug
      case data[0]
      when Array
        {
          data: is_a?(AreaChart) || is_a?(ScatterChart) ? data : data.map(&:last),
          type: type,
        }
      when Hash
        data.map do |e| 
          {
            data: e[:data].is_a?(Hash) ? e[:data].values : e[:data],
            type: type,
            name: e[:name]
          }
        end
      end
    end

    def x_axis
      {
        type: 'category',
        data: x
      }
    end

    def y_axis
      {
        type: 'value',
      }
    end

    def defaults
      {
        tooltip: {
          trigger: 'axis'
        },
        toolbox: {
          feature: {
            saveAsImage: {}
          },
        }
      }
    end

  end
end