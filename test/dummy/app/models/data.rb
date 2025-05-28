class Data
  def Data.populate
    2000.times do
      dob = Date.current - rand(100).years - rand(400).days
      user = User.create(
        name: Faker::Name.name,
        country: Faker::Address.country,
        age: Date.current.year - dob.year,
        role: ['admin', 'user', 'moderator', 'user', 'moderator', 'user', 'moderator', 'sales', 'manager', 'security'].sample,
        salary: 200 + rand(1_000),
        dob: dob,
        created_at: Time.now - rand(10000).minutes
      )
    end

    User.where(role: 'user').find_each do |user|
      user.salary = user.salary * 0.5
      user.age = rand(30)
      user.save
    end

    User.where(role: 'admin').find_each do |user|
      user.salary = user.salary * 1.4
      user.age += rand(30)
      user.save
    end

    DataPoint.generate(1_000)
    Account.populate
    Stat.populate
    Commit.generate_random_data
  end
end
