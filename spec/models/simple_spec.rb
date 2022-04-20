require_relative "../rails_helper"

describe "Charts" do
  it 'works' do
    c = RailsCharts::LineChart.new({Date.yesterday => 100, Date.current => 200, Date.tomorrow => 300})
    expect { c.js_code }.not_to raise_error
  end
end