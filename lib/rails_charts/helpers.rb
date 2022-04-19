require "json"
require "erb"

module RailsCharts
  module Helpers

    def line_chart_2(data, **options)
      klass = LineChart.new(data, options)
      raw klass.js_code
    end


    def line_chart(data, **options)
      html_id = "rails_charts_#{rand(1_000)}"

      Rails.logger.info "====="
      Rails.logger.info data
      Rails.logger.info "====="

      width  = options.delete(:width).presence || '640px'
      height = options.delete(:height).presence || '480px'
      style  = options.delete(:style)
      smooth = options.delete(:smooth).presence || false
      theme  = options.delete(:theme).presence || RailsCharts.options[:theme]
      chart_options = {
        locale: 'EN'
      }

      js = %Q{
        <div id="#{html_id}" style="width: #{width}; height: #{height}; #{style}"></div>
        <script>
          var chartDom = document.getElementById('#{html_id}');
          var myChart = echarts.init(chartDom, #{theme.to_json}, #{chart_options.to_json});
          var option;

          option = {
            title: {
              text: 'Sta111cked Area Chart'
            },
            toolbox: {
              show: true,
              feature: {
                dataZoom: {
                  yAxisIndex: 'none'
                },
                dataView: { readOnly: false },
                magicType: { type: ['line', 'bar'] },
                restore: {},
                saveAsImage: {}
              }
            },           
            tooltip: {
              trigger: 'axis',
              axisPointer: {
                type: 'cross'
              }
            }, 
            legend: {
              data: ['Email', "Zona"]
            },                       
            xAxis: {
              name: 'Age',
              type: 'category',
              data: #{rails_charts_keys(data).to_json}
            },
            yAxis: {
              type: 'value',
              name: 'Salary',
            },
            series: #{rails_charts_series(data).to_json}
          };

          option && myChart.setOption(option);
        </script>
      }

      Rails.logger.info js
      raw js
    end

    def rails_charts_keys(data)
      if data.is_a?(Array)
        data.map{|e| e[:data].keys}.uniq.flatten
      else
        data.keys
      end
    end

    def rails_charts_series(data)
      if data.is_a?(Array)
        data.map do |e|
          {
            data: e[:data].values,
            type: 'line',
            name: e[:name],
            smooth: true,
          }
        end
      else
        {
          data: data.values,
          type: 'line',
          name: 'Zona',
          smooth: true,
        }
      end
    end

  end
end
