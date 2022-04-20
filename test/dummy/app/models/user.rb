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

end
