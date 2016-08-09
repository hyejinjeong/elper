class CreateTimeSlots < ActiveRecord::Migration
  def change
    create_table :time_slots do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.integer :wday, null: false
      t.integer :start_hour_and_min, null: false
      t.integer :end_hour_and_min, null: false

      t.timestamps null: false
    end
  end
end
