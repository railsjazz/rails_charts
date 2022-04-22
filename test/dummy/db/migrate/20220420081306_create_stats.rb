require 'faker'

class CreateStats < ActiveRecord::Migration[7.0]
  def change
    create_table :stats do |t|
      t.string :country
      t.integer :year
      t.integer :amount

      t.timestamps
    end

    Stat.populate
  end
end
