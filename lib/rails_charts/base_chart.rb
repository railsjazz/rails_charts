module RailsCharts
  class BaseChart
    attr_reader :data, :options, :container_id
    attr_reader :width, :height, :style, :klass, :theme, :chart_options, :title
    attr_reader :x_title, :y_title, :toolbox, :tooltip, :legend, :vertical
    attr_reader :x_axis_options, :y_axis_options, :series_options, :grid_options

    def initialize(data, options)
      @data = data
      @options = options

      @chart_options = options.delete(:chart_options) || RailsCharts.options[:chart_options]
      @width    = options.delete(:width).presence || '640px'
      @height   = options.delete(:height).presence || '480px'
      @style    = options.delete(:style)
      @theme    = options.delete(:theme).presence || RailsCharts.options[:theme]
      @title    = options.delete(:title)
      @x_title  = options.delete(:x_title)
      @y_title  = options.delete(:y_title)
      @vertical = options.delete(:vertical).presence || false
      @klass    = options.delete(:class)

      @toolbox = options.delete(:toolbox)
      @tooltip = options.delete(:tooltip)
      @legend  = options.delete(:legend)
      
      @x_axis_options = options.delete(:x_axis_options) || {}
      @y_axis_options = options.delete(:y_axis_options) || {}
      @series_options = options.delete(:series_options) || {}
      @grid_options   = options.delete(:grid_options) || {}

      @container_id = "rails_charts_#{rand(1_000_000)}_#{Time.now.to_i}"
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
          var chartDom = document.getElementById('#{container_id}');
          var myChart = echarts.init(chartDom, "#{theme}", { "locale": "EN" });
          var option = #{options.to_json};
          option && myChart.setOption(option);
        </script>
      }
    end

    def options
      # puts '--1--'
      # puts chart_series_options
      # puts chart_series_options.class
      # puts '--2--'
      # puts series_options
      # puts series_options.class
      # puts '--3--'      
      {
        title: chart_title_options,
        toolbox: chart_toolbox_options,
        grid: chart_grid_options.merge(grid_options),
        tooltip: chart_tooltip_options,
        legend: chart_legend_options,
        series: chart_series_options.is_a?(Hash) ? chart_series_options.merge(series_options) : chart_series_options.map{|e| e.merge(series_options)},
      }.merge(axises)
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
      chart_x_axis_options.merge(x_axis_options)
    end

    def y_axis
      chart_y_axis_options.merge(y_axis_options)
    end

    def chart_title_options
      return {} if self.title.blank?

      {
        text: self.title
      }
    end

    def chart_toolbox_options
      toolbox.presence || RailsCharts::Options.toolboxes[:none]
    end

    def chart_tooltip_options
      tooltip.presence || RailsCharts::Options.tooltips[:none]
    end

    def chart_legend_options
      legend.presence || {
        data: data.is_a?(Array) ? data.map{|e| e[:name].to_s} : []
      }
    end

    def chart_x_axis_options
      {}
    end

    def chart_y_axis_options
      {}
    end

    def chart_series_options
      []
    end

    def chart_grid_options
      {}
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