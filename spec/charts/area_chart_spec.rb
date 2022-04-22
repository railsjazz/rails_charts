require_relative "../rails_helper"

describe RailsCharts::AreaChart do
  before do
    User.create(age: 10, role: 'admin', salary: 100)
    User.create(age: 20, role: 'moderator', salary: 20)
  end

  describe "#area_chart 1" do
    it "build_options" do
      chart = RailsCharts::AreaChart.new({10 => 42, 20 => 4242})
      expect(chart.build_options).to eq({
        :series=>[
          {:areaStyle=>{}, :data=>[[10,42], [20,4242]], :stack=>"Total", :type=>"line"}
        ], 
        :tooltip=>{:trigger=>"axis"},
        :toolbox => {:feature=>{:saveAsImage=>{}}},
        :xAxis=>{:type=>"category", :boundaryGap=>false},
        :yAxis=>{:type=>"value"}
      })
    end
  end

  describe "#area_chart 2" do
    it "for time" do
      DataPoint.create(event_date: Date.yesterday, value: 1)
      DataPoint.create(event_date: Date.current, value: 2)
      DataPoint.create(event_date: Date.tomorrow, value: 3)

      chart = RailsCharts::AreaChart.new(DataPoint.pluck(:event_date, :value), {
        options: {
          xAxis: {
            type: 'time'
          },
          series: {
            type: 'time'
          }
        }
      })
      expect(chart.build_options).to eq({
        :series=>[
          {:areaStyle=>{}, :data=>[[Date.yesterday, 1], [Date.current, 2], [Date.tomorrow, 3]], :stack=>"Total", :type=>"time"}
        ], 
        :tooltip=>{:trigger=>"axis"},
        :toolbox => {:feature=>{:saveAsImage=>{}}},
        :xAxis=>{:type=>"time", :boundaryGap=>false},
        :yAxis=>{:type=>"value"}
      })
    end
  end
 

end