module RailsCharts
  class BaseChart
    attr_reader :data, :options
    attr_reader :container_id
    attr_reader :width, :height, :style, :theme, :chart_options, :title

    def initialize(data, options)
      @data = data
      @options = options

      @chart_options = options.delete(:chart_options) || RailsCharts.options[:chart_options]
      @width  = options.delete(:width).presence || '640px'
      @height = options.delete(:height).presence || '480px'
      @style  = options.delete(:style)
      @theme  = options.delete(:theme).presence || RailsCharts.options[:theme]
      @title  = options.delete(:title)

      @container_id = "rails_charts_#{rand(1_000)}"
    end

    def js_code
      [
        container_div,
        script_code
      ].join
    end

    def container_div
      %Q{<div id="#{container_id}" style="width: #{width}; height: #{height}; #{style}"></div>}
    end

    def script_code
      %Q{
        <script>
          var chartDom = document.getElementById('#{container_id}');
          var myChart = echarts.init(chartDom, "dark", {"locale":"EN"});
          var option = #{options.to_json};
          option && myChart.setOption(option);
        </script>        
      }
    end

    def options
      raise 'implement me'
    end

  end
end