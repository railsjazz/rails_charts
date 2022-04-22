require_relative "../rails_helper"

describe RailsCharts::LineChart do

  describe "#area_chart 1" do
    it "build_options" do
      chart = RailsCharts::LineChart.new({10 => 42, 20 => 4242}, {options: { title: { text: "Hello" } }})
      expect(chart.build_options).to eq({
        :series=>[
          {:data=>[42, 4242], :type=>"line"}
        ],
        title: { text: "Hello" },
        :toolbox => {:feature=>{:saveAsImage=>{}}},
        :tooltip=>{:trigger=>"axis"},
        :xAxis=>{:data=>[10, 20], :type=>"category"},
        :yAxis=>{:type=>"value"}
      })
    end
  end
end