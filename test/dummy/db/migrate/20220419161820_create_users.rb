require 'faker'

class CreateUsers < ActiveRecord::Migration[7.0]
  def up
    create_table :users do |t|
      t.string :name
      t.string :country
      t.integer :age
      t.string :role
      t.integer :salary
      t.date :dob

      t.timestamps
    end

    create_table :accounts do |t|
      t.string :name
      t.integer :priority

      t.timestamps
    end
  end

  def down
    drop_table :users
    drop_table :accounts
  end
end
