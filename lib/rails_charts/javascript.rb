module RailsCharts
  class Javascript
    attr_reader :code, :record_id

    def initialize(code)
      @code      = code
      @record_id = Digest::SHA1.hexdigest([Time.now, rand].join)

      Thread.current[:rails_charts_js_code] ||= {}
      Thread.current[:rails_charts_js_code][record_id] = code
    end

    def as_json(attrs)
      record_id
    end
  end
end