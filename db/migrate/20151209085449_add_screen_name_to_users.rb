class AddScreenNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :screen_name, :string
    add_index :users, :screen_name
  end
end
