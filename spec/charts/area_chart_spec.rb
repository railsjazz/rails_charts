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
          {:areaStyle=>{}, :data=>[42, 4242], :stack=>"Total", :type=>"line"}
        ], 
        :tooltip=>{:trigger=>"axis"},
        :toolbox => {:feature=>{:saveAsImage=>{}}},
        :xAxis=>{:data=>[10, 20], :type=>"category", :boundaryGap=>false},
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

    #  expect(chart.x).to eq([Date.yesterday, Date.today])
     # expect(chart.y).to eq([1,2,1])
      expect(chart.build_options[:series]).to eq([{:areaStyle=>{}, :data=>[1, 2, 3], :stack=>"Total", :type=>"time"}])

      expect(chart.build_options).to eq({
        :series=>[
          {:areaStyle=>{}, :data=>[1, 2, 3], :stack=>"Total", :type=>"time"}
        ], 
        :tooltip=>{:trigger=>"axis"},
        :toolbox => {:feature=>{:saveAsImage=>{}}},
        :xAxis=>{:data=>[Date.yesterday, Date.today, Date.tomorrow], :type=>"time", :boundaryGap=>false},
        :yAxis=>{:type=>"value"}
      })
    end
  end
 

end