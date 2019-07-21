class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.time :open_time
      t.time :close_time
      t.integer :day_of_week
      t.references :restaurant, index: true, foreign_key: true
    end
  end
end
