# == Schema Information
#
# Table name: data_points
#
#  id         :integer          not null, primary key
#  value      :integer
#  event_date :date
#
class DataPoint < ApplicationRecord

  def DataPoint.generate(n = 1000)
    DataPoint.delete_all

    start = 30.years.ago
    DataPoint.data_set(n).each_with_index do |value, i|
      DataPoint.create(
        value: value,
        event_date: start + i.days
      )
    end
  end

  def DataPoint.data_set(n = 1000)
    result = []
    n.times do |e|
      value = Math.sin(0.005 * Math::PI * (e % n) / Math::PI) * 100000000
      result << (value / 100000).to_i + rand(n/10)
    end
    result
  end

end
