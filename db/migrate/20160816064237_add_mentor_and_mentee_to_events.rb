class AddMentorAndMenteeToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :mentor, index: true, foreign_key: true
    add_reference :events, :mentee, index: true, foreign_key: true
    remove_reference :events, :user, index: true, foreign_key: true
  end
end
