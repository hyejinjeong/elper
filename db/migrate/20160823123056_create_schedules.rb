class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.references :event, index: true, foreign_key: true
      t.datetime :start_datetime
      t.datetime :end_datetime

      t.timestamps null: false
    end
  end
end
