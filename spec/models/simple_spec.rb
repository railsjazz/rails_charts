require_relative "../rails_helper"

describe "Charts" do
  using RailsCharts::RubyExt

  it 'works' do
    c = RailsCharts::LineChart.new({Date.yesterday => 100, Date.current => 200, Date.tomorrow => 300})
    expect { c.js_code }.not_to raise_error
  end

  it 'can do nested merge' do
    expect([{}, {a: 1}].deep_merge({b: 1})).to eq([{:b=>1}, {:a=>1, :b=>1}])
  end

  describe "deep merge" do
    it 'works' do
      conf = {
        tooltip: {
          show: true
        },
        series: {
          data: {
            color: 'red'
          }
        }
      }

      options = {
        tooltip: {
          text: "hello"
        },
        series: {
          name: 'xxxx',
          data: {
            value: 1
          }
        }
      }

      expect(conf.deep_merge(options)).to eq({
        tooltip: {
          show: true,
          text: "hello"
        },
        series: {
          name: 'xxxx',
          data: {
            color: 'red',
            value: 1
          }
        }
      })
    end
  end
end