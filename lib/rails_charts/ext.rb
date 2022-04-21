module RailsCharts

  module Ext

    refine ::Array do
      def deep_merge(other)
        map{|e| e.merge!(other) } 
      end
    end

  end

end