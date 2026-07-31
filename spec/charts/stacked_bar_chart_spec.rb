require_relative "../rails_helper"

describe RailsCharts::StackedBarChart do
  describe "#build_options" do
    it "preserves per-series options while defaulting the stack" do
      chart = described_class.new([
        {
          name: 'Actual',
          data: { 'Monday' => 8, 'Tuesday' => 6 },
          stack: 'Observed',
          itemStyle: { color: '#166534' }
        },
        {
          name: 'Forecast',
          data: { 'Tuesday' => 2, 'Wednesday' => 1 },
          barWidth: '40%'
        }
      ])

      expect(chart.build_options).to include(
        xAxis: {
          type: 'category',
          data: ['Monday', 'Tuesday', 'Wednesday']
        },
        series: [
          {
            stack: 'Observed',
            name: 'Actual',
            itemStyle: { color: '#166534' },
            data: [8, 6, nil],
            type: 'bar'
          },
          {
            stack: 'stack',
            name: 'Forecast',
            barWidth: '40%',
            data: [nil, 2, 1],
            type: 'bar'
          }
        ]
      )
    end
  end
end
