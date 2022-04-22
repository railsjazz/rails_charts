module RailsCharts
  class BaseChart
    using Ext

    attr_reader :data, :options, :container_id, :defaults
    attr_reader :width, :height, :style, :klass, :theme, :locale
    attr_reader :other_options, :debug
    attr_reader :vertical

    def initialize(data, options = {})
      @data          = data
      @options       = options
      @other_options = options.delete(:options).presence || {}
      @defaults      = RailsCharts.defaults[self.class].presence || {}

      @container_id  = options.delete(:id).presence || "rails_charts_#{Digest::SHA1.hexdigest([Time.now, rand].join)}"

      @width         = options.delete(:width).presence || RailsCharts.options[:width]
      @height        = options.delete(:height).presence || RailsCharts.options[:height]
      @theme         = options.delete(:theme).presence || RailsCharts.options[:theme]
      @locale        = options.delete(:locale).presence || RailsCharts.options[:locale]
      @klass         = options.delete(:class).presence || RailsCharts.options[:class]
      @style         = options.delete(:style).presence || RailsCharts.options[:style]
     
      @debug         = options.delete(:debug)

      @vertical      = options.delete(:vertical).presence
    end

    def js_code
      style_css = []
      style_css << "width: #{width}" if width
      style_css << "height: #{height}" if height
      style_css << style

      %Q{
        <div id="#{container_id}" class="#{klass}" style="#{style_css.compact.join('; ')}">
          <script>
            <!-- #{self.class} -->
            var chartDom = document.getElementById('#{container_id}');
            var myChart = echarts.init(chartDom, #{theme.to_json}, { "locale": #{locale.to_json} });
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

  end
end