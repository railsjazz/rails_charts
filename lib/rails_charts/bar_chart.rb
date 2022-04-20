module RailsCharts
  class BarChart < LineChart
    
    def initialize(data, options = {})
      super(data, options)
    end

    def type
      'bar'
    end
  
  end
end