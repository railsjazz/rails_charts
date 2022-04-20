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
end
