module RailsCharts
  class LineChart < BaseChart
    attr_reader :smooth

    def initialize(data, options)
      super(data, options)

      @smooth = options.delete(:smooth).presence || false
    end

    def options
      {
        title: {
          text: self.title
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
          data: ["2022-04-12","2022-04-13","2022-04-14","2022-04-15","2022-04-16","2022-04-17","2022-04-18","2022-04-19"]
        },
        yAxis: {
          type: 'value',
          name: 'Salary',
        },
        series: [{"data":[14,114,94,99,101,89,83,88],"type":"line","name":"moderator","smooth":true},{"data":[10,97,102,79,99,99,88,79],"type":"line","name":"admin","smooth":true},{"data":[13,98,93,99,98,99,93,72],"type":"line","name":"user","smooth":true}]
      }
    end
  end
end