class Commit < ApplicationRecord

  def Commit.generate_random_data
    Commit.delete_all

    5000.times do |e|
      Commit.create(created_at: rand(700).days.ago)
    end    

    2000.times do |e|
      Commit.create(created_at: rand(100..300).days.ago)
    end

    100.times do |e|
      Commit.create(created_at: rand(200..300).days.ago)
    end

    100.times do |e|
      Commit.create(created_at: rand(40..100).days.ago)
    end

    50.times do |e|
      Commit.create(created_at: rand(50..80).days.ago)
    end    
  end

  def Commit.for_calendar_chart
    {
      data: Commit.group_by_day(:created_at).count.to_a
    }
  end

end
