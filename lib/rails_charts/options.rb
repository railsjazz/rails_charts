module RailsCharts
  module Options

    def Options.toolboxes
      {
        none: nil,
        download_image: {
          show: true,
          feature: {
            saveAsImage: {}
          }
        },
        download_image_stack_tiled: {
          show: true,
          feature: {
            magicType: { show: true, type: ['stack', 'tiled', 'bar'] },
            saveAsImage: { show: true }
          }
        },
        download_image_zoom: {
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
        }
      }
    end

    def Options.tooltips
      {
        none: nil,
        point: {},
        item: {
          trigger: 'item',
        },
        axis_cross: {
          trigger: 'axis',
          axisPointer: {
            type: 'cross'
          }
        },
        axis_shadow: {
          trigger: 'axis',
          axisPointer: {
            type: 'shadow'
          }
        },
        axis: {
          trigger: 'axis',
        },        
      }
    end

  end
end