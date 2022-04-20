class CreateCommits < ActiveRecord::Migration[7.0]
  def change
    create_table :commits do |t|
      t.datetime :created_at
    end

    Commit.generate_random_data
  end
end
