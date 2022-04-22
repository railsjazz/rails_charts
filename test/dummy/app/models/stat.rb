# == Schema Information
#
# Table name: stats
#
#  id         :integer          not null, primary key
#  country    :string
#  year       :integer
#  amount     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Stat < ApplicationRecord

  def Stat.populate
    Stat.delete_all
    ['Brazil', 'Indonesia', 'USA', 'India', 'China', 'Europe'].each do |country|
      [2022, 2021].each do |year|
        Stat.create(
          country: country,
          year: year,
          amount: 100 * rand(1000),
          created_at: rand(60).days.ago
        )
      end
    end
  end    

end
