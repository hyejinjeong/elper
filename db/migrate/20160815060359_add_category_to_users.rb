class AddCategoryToUsers < ActiveRecord::Migration
  def change
    add_column :users, :category, :integer, default: 1
  end
end
