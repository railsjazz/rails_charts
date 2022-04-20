module RailsCharts
  class BaseChart
    attr_reader :data, :options, :container_id
    attr_reader :width, :height, :style, :klass, :theme, :rails_charts_options, :other_options
    attr_reader :x_title, :y_title, :toolbox, :tooltip, :legend, :vertical
    attr_reader :x_axis_options, :y_axis_options, :series_options, :grid

    def initialize(data, options = {})
      @data                 = data
      @options              = options
      @rails_charts_options = options.delete(:rails_charts_options).presence || RailsCharts.options
      @other_options        = options.delete(:other_options).presence || {}

      @width    = options.delete(:width).presence || '100%'
      @height   = options.delete(:height).presence || '450px'
      @style    = options.delete(:style)
      @theme    = options.delete(:theme).presence || rails_charts_options[:theme] || RailsCharts.options[:theme]
      @x_title  = options.delete(:x_title)
      @y_title  = options.delete(:y_title)
      @vertical = options.delete(:vertical).presence || false
      @klass    = options.delete(:class)

      @toolbox  = options.delete(:toolbox)
      @tooltip  = options.delete(:tooltip)
      @legend   = options.delete(:legend)
      @grid     = options.delete(:grid)
      
      @x_axis_options = options.delete(:x_axis_options) || {}
      @y_axis_options = options.delete(:y_axis_options) || {}
      @series_options = options.delete(:series_options) || {}

      @container_id = "rails_charts_#{rand(1_000_000_000)}_#{Time.now.to_i}"
    end

    def js_code
      [container_div, script_code].join
    end

    def container_div
      %Q{<div id="#{container_id}" class="#{klass}" style="width: #{width}; height: #{height}; #{style}"></div>}
    end

    def script_code
      %Q{
        <script>
          <!-- #{self.class} -->
          var chartDom = document.getElementById('#{container_id}');
          var myChart = echarts.init(chartDom, "#{theme}", { "locale": "EN" });
          var option = #{build_options.to_json};
          option && myChart.setOption(option);
        </script>
      }
    end

    def build_options
      hash            = {}
      hash[:toolbox]  = toolbox if toolbox
      hash[:grid]     = grid if grid
      hash[:tooltip]  = tooltip if tooltip
      hash[:legend]   = legend if legend
      hash[:series]   = series
      hash.merge(axises).merge(other_options)
    end

    def series
      Array.wrap(generate_series_options).map{|e| e.merge(series_options)}
    end

    def axises
      if self.vertical
        {
          xAxis: y_axis,
          yAxis: x_axis,
        }
      else
        {
          xAxis: x_axis,
          yAxis: y_axis,
        }
      end
    end

    def x_axis
      generate_x_axis_options.merge(x_axis_options)
    end

    def y_axis
      generate_y_axis_options.merge(y_axis_options)
    end

    def generate_x_axis_options
      {}
    end

    def generate_y_axis_options
      {}
    end

    def generate_series_options
      []
    end

    def x_axis_data(data)
      if data.is_a?(Array)
        data.map{|e| e[:data].keys}.uniq.flatten
      else
        data.keys
      end
    end

  end
end