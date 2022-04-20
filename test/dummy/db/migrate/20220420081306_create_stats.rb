require 'faker'

class CreateStats < ActiveRecord::Migration[7.0]
  def change
    create_table :stats do |t|
      t.string :country
      t.integer :year
      t.integer :amount

      t.timestamps
    end

    ['Brazil', 'Indonesia', 'USA', 'India', 'China', 'Europe'].each do |country|
      [2022, 2021].each do |year|
        Stat.create(
          country: country,
          year: year,
          amount: 100 * rand(1000)
        )
      end
    end
  end
end
