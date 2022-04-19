require "rails_charts/version"
require "rails_charts/railtie"
require "rails_charts/helpers"


module RailsCharts
  class << self
    attr_accessor :options
  end
  self.options = {}
end
