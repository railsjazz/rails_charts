module RailsCharts
  class LineChart < BaseChart

    def initialize(data, options = {})
      super(Array.wrap(data.to_a), options)
    end

    def type
      'line'
    end

    def x
      case data[0]
      when Array
        data.map{|e| e[0]}
      when Hash
        data.map{|e| e[:data].keys}.flatten
      else
        nil
      end&.uniq
    end

    def y
      case data[0]
      when Array
        data.map{|e| e[1]}
      when Hash
        data.map{|e| e[:name]}
      end
    end    

    # if [[a, 1], [b, 2]]
    # if [{name: "a", data: [1,2,3]}, {name: "b", data: [1,2,3]}]
    # [
    #  {:name=>"security",
    #    :data=>{Wed, 13 Apr 2022=>2, Thu, 14 Apr 2022=>31, Fri, 15 Apr 2022=>23, Sat, 16 Apr 2022=>22, Sun, 17 Apr 2022=>27, Mon, 18 Apr 2022=>35, Tue, 19 Apr 2022=>27, Wed, 20 Apr 2022=>18}},
    #  {:name=>"user",
    #   :data=>{Wed, 13 Apr 2022=>30, Thu, 14 Apr 2022=>89, Fri, 15 Apr 2022=>92, Sat, 16 Apr 2022=>95, Sun, 17 Apr 2022=>92, Mon, 18 Apr 2022=>96, Tue, 19 Apr 2022=>85, Wed, 20 Apr 2022=>54}},
    #  {:name=>"moderator",
    #   :data=>{Wed, 13 Apr 2022=>24, Thu, 14 Apr 2022=>92, Fri, 15 Apr 2022=>72, Sat, 16 Apr 2022=>81, Sun, 17 Apr 2022=>95, Mon, 18 Apr 2022=>99, Tue, 19 Apr 2022=>84, Wed, 20 Apr 2022=>49}},
    #  {:name=>"admin",
    #   :data=>{Wed, 13 Apr 2022=>9, Thu, 14 Apr 2022=>23, Fri, 15 Apr 2022=>29, Sat, 16 Apr 2022=>22, Sun, 17 Apr 2022=>30, Mon, 18 Apr 2022=>18, Tue, 19 Apr 2022=>32, Wed, 20 Apr 2022=>10}},
    #  {:name=>"sales",
    #   :data=>{Wed, 13 Apr 2022=>19, Thu, 14 Apr 2022=>25, Fri, 15 Apr 2022=>31, Sat, 16 Apr 2022=>31, Sun, 17 Apr 2022=>39, Mon, 18 Apr 2022=>41, Tue, 19 Apr 2022=>22, Wed, 20 Apr 2022=>18}},
    #  {:name=>"manager",
    #   :data=>{Wed, 13 Apr 2022=>9, Thu, 14 Apr 2022=>24, Fri, 15 Apr 2022=>36, Sat, 16 Apr 2022=>21, Sun, 17 Apr 2022=>25, Mon, 18 Apr 2022=>32, Tue, 19 Apr 2022=>30, Wed, 20 Apr 2022=>10}}
    # ]    

    def generate_series_options
 #     binding.pry if debug
      case data[0]
      when Array
  #      binding.pry if debug
        {
          data: data.map(&:last),
          type: type,
#          _path: 'ARRAY'
        }
      when Hash
        data.map do |e| 
          {
#            _path: 'HASH',
            data: e[:data].values,
            type: type,
            name: e[:name]
          }
        end
      end

      # if data.is_a?(Array)
      #   data.map do |e|
      #     if e.is_a?(Hash)
      #       {
      #         data: e[:data].values,
      #         type: type,
      #         name: e[:name].to_s,
      #       }
      #     elsif e.is_a?(Array)
      #       {
      #         data: e[1],
      #         type: type,
      #       }
      #     end
      #   end
      # else
      #   {
      #     data: data.values,
      #     type: type,
      #   }
      # end
    end

    def x_axis
      {
        type: 'category',
        data: x
      }
    end

    def y_axis
      {
        type: 'value',
      }
    end

    def defaults
      {
        tooltip: {
          trigger: 'axis'
        },
        toolbox: {
          feature: {
            saveAsImage: {}
          },
        }
      }
    end

  end
end