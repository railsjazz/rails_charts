require_relative "../rails_helper"

describe RailsCharts::LineChart do

  describe "#area_chart 1" do
    it "build_options" do
      chart = RailsCharts::LineChart.new({10 => 42, 20 => 4242})
      expect(chart.build_options).to eq({
        :series=>[
          {:data=>[42, 4242], :name=>"", :type=>"line"}
        ],
        :tooltip=>{:trigger=>"axis"},
        :xAxis=>{:data=>[10, 20], :name=>nil, :type=>"category"},
        :yAxis=>{:name=>nil, :type=>"value"}
      })
    end
  end
end