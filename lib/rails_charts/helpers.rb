require "json"
require "erb"

module RailsCharts
  module Helpers
    def line_chart(data, **options)
      html_id = "rails_charts_#{rand(1_000)}"

      width  = options.delete(:width).presence || '640px'
      height = options.delete(:height).presence || '480px'
      style  = options.delete(:style)

      js = %Q{
        <div id="#{html_id}" style="width: #{width}; height: #{height}; #{style}"></div>
        <script>
          var chartDom = document.getElementById('#{html_id}');
          var myChart = echarts.init(chartDom, "#{RailsCharts.options[:theme]}");
          var option;

          option = {
            title: {
              text: 'Sta111cked Area Chart'
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
              data: #{data.keys.map(&:to_s)}
            },
            yAxis: {
              type: 'value',
              name: '344455555',
            },
            series: [
              {
                data: #{data.values},
                type: 'line',
                name: 'Email',
              },
              {
                data: #{data.values.map{|i| i + rand(12)}},
                type: 'line',
                name: 'Zona',
              }              
            ]
          };

          option && myChart.setOption(option);
        </script>
      }

      #Rails.logger.info js
      raw js
    end
  end
end
