module RailsCharts
  class Javascript
    attr_reader :code

    def initialize(code)
      @code = code
    end

    def as_json(options = nil)
      "RAILS_CHART_JS:#{Base64.strict_encode64(code)}:RAILS_CHART_JS_END"
    end
  end
end
