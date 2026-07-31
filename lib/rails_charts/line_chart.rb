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
        data.flat_map { |series| keyed_series_data(series).keys }
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
      # binding.pry if debug
      case data[0]
      when Array
        series_defaults.merge(
          data: is_a?(AreaChart) || is_a?(ScatterChart) ? data : data.map(&:last),
          type: type,
        )
      when Hash
        categories = x

        data.map do |e|
          series_defaults
            .merge(e.except(:data, :type))
            .merge(
              data: series_values(e, categories),
              type: type,
            )
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

    private

    def series_defaults
      {}
    end

    def series_values(series, categories)
      return series[:data] if is_a?(ScatterChart)

      values_by_category = keyed_series_data(series)
      categories.map { |category| values_by_category[category] }
    end

    def keyed_series_data(series)
      series[:data].is_a?(Hash) ? series[:data] : series[:data].to_h
    end

  end
end
