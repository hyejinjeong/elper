class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.references :user, index: true, foreign_key: true
      t.date :start_date
      t.integer :period
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps null: false
    end
  end
end
