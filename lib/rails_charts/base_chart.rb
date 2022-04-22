module RailsCharts
  class BaseChart
    using Ext

    attr_reader :data, :options, :container_id
    attr_reader :width, :height, :style, :klass, :theme, :rails_charts_options, :other_options
    attr_reader :vertical

    def initialize(data, options = {})
      @data                 = data
      @options              = options
      @rails_charts_options = options.delete(:rails_charts_options).presence || RailsCharts.options
      @other_options        = options.delete(:options).presence || {}

      @width    = options.delete(:width).presence || '100%'
      @height   = options.delete(:height).presence || '450px'
      @style    = options.delete(:style)
      @theme    = options.delete(:theme).presence || rails_charts_options[:theme] || RailsCharts.options[:theme]
      @vertical = options.delete(:vertical).presence || false
      @klass    = options.delete(:class)

      @container_id = "rails_charts_#{Digest::SHA1.hexdigest([Time.now, rand].join)}"
    end

    def js_code
      %Q{
        <div id="#{container_id}" class="#{klass}" style="width: #{width}; height: #{height}; #{style}">
          <script>
            <!-- #{self.class} -->
            var chartDom = document.getElementById('#{container_id}');
            var myChart = echarts.init(chartDom, "#{theme}", { "locale": "EN" });
            var option = #{build_options.to_json};
            option && myChart.setOption(option);
          </script>
        </div>
      }
    end

    def build_options
      hash = {}

      hash[:series] = Array.wrap(generate_series_options)

      hash = hash.complex_merge(axises)
      hash = hash.complex_merge(defaults)
      hash = hash.complex_merge(other_options)

      hash
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
      []
    end

    def y_axis
      []
    end

    def defaults
      @defaults ||= RailsCharts.defaults[self.class].presence || {}
    end    

  end
end