require_relative "../rails_helper"

describe RailsCharts::AreaChart do

  describe "#area_chart 1" do
    it "build_options" do
      chart = RailsCharts::AreaChart.new({10 => 42, 20 => 4242})
      expect(chart.build_options).to eq({
        :series=>[
          {:areaStyle=>{}, :data=>[42, 4242], :name=>"", :stack=>"Total", :type=>"line"}
        ], 
        :xAxis=>{:data=>[10, 20], :name=>nil, :type=>"category", :boundaryGap=>false},
        :yAxis=>{:name=>nil, :type=>"value"}
      })
    end
  end
end