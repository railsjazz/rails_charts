class CreateDataPoints < ActiveRecord::Migration[7.0]
  def change
    create_table :data_points do |t|
      t.integer :value
      t.date :event_date
    end
  end
end
