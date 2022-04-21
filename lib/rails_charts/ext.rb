module RailsCharts

  module Ext

    refine ::Array do
      def deep_merge(other)
        puts "------ #{self} + merge #{other} ------"

        map{|e| e.merge!(other) } 
      end
    end

    refine ::Hash do
      def complex_deep_merge(other)
        self.merge(other) do |key, oldval, newval|
          if self[key].is_a?(Array)
          else
            self[key]
          end
        end
      end
    end

  end

end