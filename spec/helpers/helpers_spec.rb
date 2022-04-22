require_relative "../rails_helper"

describe RailsCharts::Helpers do
  before do
    User.create(age: 10, role: 'admin', salary: 100)
    User.create(age: 20, role: 'moderator', salary: 20)
    User.create(age: 30, role: 'user', salary: 50)
  end

  describe "#line_chart" do
    it "works" do
      expect { helper.line_chart(User.group(:age).count, width: '1000px', height: '300px', theme: 'vintage') }.not_to raise_error
    end

    it "works multiline" do
      data = User.distinct.pluck(:role).map{|e| {name: e, data: User.where(role: e).group_by_day(:created_at).count} }
      expect { helper.line_chart(data, width: '1000px', theme: 'infographic') }.not_to raise_error
    end
  end

  describe "#area_chart" do
    it "works" do
      expect { helper.area_chart(User.group(:age).count, width: '1000px', height: '300px', theme: 'vintage') }.not_to raise_error
    end
  end

  describe "#bar_chart" do
    it "works" do
      expect { helper.bar_chart(User.group(:age).count, width: '1000px', height: '300px', theme: 'vintage') }.not_to raise_error
    end

    it "works (vertical)" do
      expect { helper.bar_chart(User.group(:age).count, vertical: true, style: "margin: 0 auto", width: '1000px', height: '300px', theme: 'vintage') }.not_to raise_error
    end    
  end

  describe "#pie_chart" do
    it "works" do
      expect { helper.pie_chart(User.group(:age).count, class: 'some_ui_class', width: '1000px', height: '300px', theme: 'vintage') }.not_to raise_error
    end
  end

  describe "donut_chart" do
    it "works" do
      expect { helper.donut_chart(User.group(:age).count, radius: ['50%', '70%'], width: '1000px', height: '300px', theme: 'vintage') }.not_to raise_error
    end
  end

  describe "radar_chart" do
    it "works" do
      expect { helper.radar_chart(User.get_data_for_radar_chart, width: '1000px', height: '300px', theme: 'vintage') }.not_to raise_error
    end
  end

  describe "calendar_chart" do
    it "works" do
      expect { helper.calendar_chart(User.get_data_for_radar_chart) }.not_to raise_error
    end
  end  

  describe "funnel_chart" do
    it "works" do
      expect { helper.funnel_chart(User.get_funnel_sample_data) }.not_to raise_error
    end
  end 

  describe "gauge_chart" do
    it "works" do
      expect { helper.funnel_chart(User.get_gauge_sample_data) }.not_to raise_error
    end
  end

  describe "custom_chart" do
    it "works" do
      options = {
        series: [
          {
            type: 'gauge',
            center: ['50%', '60%'],
            startAngle: 200,
            endAngle: -20,
            min: 0,
            max: 60,
            splitNumber: 12,
            itemStyle: {
              color: '#FFAB91'
            },
            progress: {
              show: true,
              width: 30
            },
            pointer: {
              show: false
            },
            axisLine: {
              lineStyle: {
                width: 30
              }
            },
            axisTick: {
              distance: -45,
              splitNumber: 5,
              lineStyle: {
                width: 2,
                color: '#999'
              }
            },
            splitLine: {
              distance: -52,
              length: 14,
              lineStyle: {
                width: 3,
                color: '#999'
              }
            },
            axisLabel: {
              distance: -20,
              color: '#999',
              fontSize: 20
            },
            anchor: {
              show: false
            },
            title: {
              show: false
            },
            detail: {
              valueAnimation: true,
              width: '60%',
              lineHeight: 40,
              borderRadius: 8,
              offsetCenter: [0, '-15%'],
              fontSize: 60,
              fontWeight: 'bolder',
              formatter: '{value} °C',
              color: 'auto'
            },
            data: [
              {
                value: 20
              }
            ]
          },
          {
            type: 'gauge',
            center: ['50%', '60%'],
            startAngle: 200,
            endAngle: -20,
            min: 0,
            max: 60,
            itemStyle: {
              color: '#FD7347'
            },
            progress: {
              show: true,
              width: 8
            },
            pointer: {
              show: false
            },
            axisLine: {
              show: false
            },
            axisTick: {
              show: false
            },
            splitLine: {
              show: false
            },
            axisLabel: {
              show: false
            },
            detail: {
              show: false
            },
            data: [
              {
                value: 20
              }
            ]
          }
        ]
      }

      expect { helper.custom_chart(options)}.not_to raise_error
    end
  end   

end