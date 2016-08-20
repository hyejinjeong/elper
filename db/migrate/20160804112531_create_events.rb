class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.references :user, index: true, foreign_key: true, null: false
      t.date :start_date, null: false
      t.integer :period, null: false
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps null: false
    end
  end
end
