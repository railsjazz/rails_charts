module RailsCharts
  class CustomChart < BaseChart

    def initialize(data, options = {})
      super([], options)
      @options = options
    end

    def build_options
      options
    end

  end
end