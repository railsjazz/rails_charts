require "rails_charts/version"
require "rails_charts/ext"
require "rails_charts/railtie"
require "rails_charts/options"
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
  extend Options

  using Ext

  class << self
    attr_accessor :options
    attr_accessor :defaults
  end

  self.options = {}
  self.defaults = {
    RailsCharts::LineChart => {

    },
    RailsCharts::AreaChart => {
      xAxis: {
        boundaryGap: false
      },
      series: {
        areaStyle: {},
        stack: 'Total'
      }
    },
    RailsCharts::DonutChart => {
      series: {
        radius: ['40%', '70%']
      }
    }
  }
end
