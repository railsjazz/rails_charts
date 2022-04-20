require "rails_charts/version"
require "rails_charts/railtie"
require "rails_charts/options"
require "rails_charts/base_chart"
require "rails_charts/line_chart"
require "rails_charts/bar_chart"
require "rails_charts/pie_chart"
require "rails_charts/donut_chart"
require "rails_charts/area_chart"
require "rails_charts/radar_chart"
require "rails_charts/helpers"

module RailsCharts
  class << self
    attr_accessor :options
  end
  self.options = {}
end
