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

  describe "#area_chart multi-series" do
    it "preserves per-series defaults, overrides, and category alignment" do
      chart = RailsCharts::AreaChart.new([
        {
          name: 'Actual',
          data: { 'Monday' => 12, 'Tuesday' => 14 },
          stack: 'Observed',
          areaStyle: { opacity: 0.3 },
          color: '#166534'
        },
        {
          name: 'Required',
          data: { 'Tuesday' => 15, 'Wednesday' => 15 },
          lineStyle: { width: 6 }
        }
      ])

      expect(chart.build_options).to include(
        xAxis: {
          type: 'category',
          data: ['Monday', 'Tuesday', 'Wednesday'],
          boundaryGap: false
        },
        series: [
          {
            areaStyle: { opacity: 0.3 },
            stack: 'Observed',
            name: 'Actual',
            color: '#166534',
            data: [12, 14, nil],
            type: 'line'
          },
          {
            areaStyle: {},
            stack: 'Total',
            name: 'Required',
            lineStyle: { width: 6 },
            data: [nil, 15, 15],
            type: 'line'
          }
        ]
      )
    end
  end
 

end
