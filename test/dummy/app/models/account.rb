# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  name       :string
#  priority   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Account < ApplicationRecord

  scope :high_priority, -> { where("priority >= 60") }
  scope :low_priority, -> { where("priority < 60") }

  def Account.populate
    Account.delete_all
    2000.times do
      dob = Date.current - rand(100).years - rand(400).days
      user = Account.create(
        name: Faker::Name.name,
        priority: rand(100),
        created_at: Time.now - rand(100000).minutes
      )
    end
  end
end
