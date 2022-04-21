# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  country    :string
#  age        :integer
#  role       :string
#  salary     :integer
#  dob        :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord

  def User.get_data_for_radar_chart
    @get_data_for_radar_chart ||= begin
      roles = User.distinct.pluck(:role)
      {
        indicators: roles.inject({}) {|res, e| res[e] = User.maximum(:salary); res},
        data: [
          {
            name: 'Average Salaries',
            value: roles.map{|e| User.where(role: e).average(:salary).round(2)}
          },
          {
            name: 'Maximum Salary',
            value: roles.map{|e| User.where(role: e).maximum(:salary).round(2)}
          }
        ],
      }
    end
  end

  def User.get_funnel_sample_data
    {
      data: [
        { value: 60, name: 'Visit' },
        { value: 40, name: 'Inquiry' },
        { value: 20, name: 'Order' },
        { value: 80, name: 'Click' },
        { value: 100, name: 'Show' }
      ]
    }
  end

  def User.get_gauge_sample_data
    {
      data: [
        {name: 'Active Users', value: 42}
      ]
    }
  end

  def User.custom_gause_data
    {
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
  end

end
