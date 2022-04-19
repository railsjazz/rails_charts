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

    2000.times do
      dob = Date.current - rand(100).years - rand(400).days
      user = User.create(
        name: Faker::Name.name,
        country: Faker::Address.country,
        age: Date.current.year - dob.year,
        role: ['admin', 'user', 'moderator'].sample,
        salary: 200 + rand(1_000),
        dob: dob,
        created_at: Time.now - rand(10000).minutes
      )
    end

    create_table :accounts do |t|
      t.string :name
      t.integer :priority

      t.timestamps
    end

    2000.times do
      dob = Date.current - rand(100).years - rand(400).days
      user = Account.create(
        name: Faker::Name.name,
        priority: rand(100),
        created_at: Time.now - rand(10000).minutes
      )
    end    
  end

  def down
    drop_table :users
    drop_table :accounts
  end
end
