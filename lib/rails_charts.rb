require "rails_charts/version"
require "rails_charts/ext"
require "rails_charts/railtie"
require "rails_charts/base_chart"
require "rails_charts/line_chart"
require "rails_charts/bar_chart"
require "rails_charts/pie_chart"
require "rails_charts/donut_chart"
require "rails_charts/area_chart"
require "rails_charts/radar_chart"
require "rails_charts/calendar_chart"
require "rails_charts/funnel_chart"
require "rails_charts/gauge_chart"
require "rails_charts/custom_chart"
require "rails_charts/helpers"

module RailsCharts
  using Ext

  class << self
    attr_accessor :options
    attr_accessor :defaults
  end

  self.options = {}
  self.defaults = {
    RailsCharts::AreaChart => {
      tooltip: {
        trigger: 'axis'
      },      
      xAxis: {
        boundaryGap: false
      },
      series: {
        areaStyle: {},
        stack: 'Total'
      },
      toolbox: {
        feature: {
          saveAsImage: {}
        },
      }
    },

    RailsCharts::LineChart => {
      tooltip: {
        trigger: 'axis'
      },
      toolbox: {
        feature: {
          saveAsImage: {}
        },
      }
    },

    RailsCharts::BarChart => {
      tooltip: {
        trigger: 'axis',
        axisPointer: {
          type: 'shadow'
        }        
      },
      toolbox: {
        feature: {
          saveAsImage: {}
        },
      }     
    },

    RailsCharts::CalendarChart => {
      tooltip: {
        item: {
          trigger: 'item',
        },
      },
    },

    RailsCharts::FunnelChart => {
      tooltip: {
        item: {
          trigger: 'item',
        },
      },
    },

    RailsCharts::GaugeChart => {
      tooltip: {
        item: {
          trigger: 'item',
        },
      },
    },

    RailsCharts::PieChart => {
      tooltip: {
        item: {
          trigger: 'item',
        },      
      },
      series: {
        radius: '70%',
      },
      emphasis: {
        itemStyle: {
          shadowBlur: 10,
          shadowOffsetX: 0,
          shadowColor: 'rgba(0, 0, 0, 0.5)'
        }
      }
    },

    RailsCharts::RadarChart => {
      tooltip: {
        item: {
          trigger: 'item',
        },
      },
    },

    RailsCharts::DonutChart => {
      tooltip: {
        item: {
          trigger: 'item',
        },
      }, 
      series: {
        radius: ['40%', '70%']
      },
      emphasis: {
        itemStyle: {
          shadowBlur: 10,
          shadowOffsetX: 0,
          shadowColor: 'rgba(0, 0, 0, 0.5)'
        }
      } 
    }
  }
end
