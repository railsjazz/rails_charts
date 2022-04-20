module RailsCharts
  class AreaChart < LineChart
    
    def initialize(data, options = {})
      options ||= {}
      options[:x_axis_options] ||= {}
      options[:x_axis_options][:boundaryGap] = false
      options[:series_options] ||= {}
      options[:series_options][:areaStyle] = {}
      options[:series_options][:stack] = 'Total'
      super(data, options)
    end

  end
end