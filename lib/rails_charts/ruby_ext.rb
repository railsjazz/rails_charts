module RailsCharts

  module RubyExt

    refine ::Array do
      def deep_merge(other)
        map{|e| e.merge!(other) } 
      end
    end

    refine ::Hash do
      def complex_merge(other)
        self.each do |k, v|
          next unless default = other[k]
          if v.is_a?(Array) || v.is_a?(Hash)
            self[k] = v.deep_merge(default)
          else
            self[k] = default
          end
        end
        self.deep_merge!(other.except(*self.keys))
        self
      end
    end    

  end

end