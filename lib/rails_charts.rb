require "rails_charts/version"
require "rails_charts/ext"
require "rails_charts/railtie"
require "rails_charts/base_chart"
require "rails_charts/line_chart"
require "rails_charts/bar_chart"
require "rails_charts/stacked_bar_chart"
require "rails_charts/pie_chart"
require "rails_charts/donut_chart"
require "rails_charts/area_chart"
require "rails_charts/radar_chart"
require "rails_charts/calendar_chart"
require "rails_charts/funnel_chart"
require "rails_charts/gauge_chart"
require "rails_charts/scatter_chart"
require "rails_charts/custom_chart"
require "rails_charts/helpers"

module RailsCharts
  using Ext

  class << self
    attr_accessor :options, :defaults
  end

  self.options = {
    theme: nil,
    width: "100%",
    height: "450px",
    css_klass: "rails_charts",
    style: nil
  }

  self.defaults = {
    # RailsCharts::DonutChart => {
    #   ...
    # }
  }
end
