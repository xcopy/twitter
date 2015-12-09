class RenameUsersUsername < ActiveRecord::Migration
  def change
    remove_index :users, column: :username
    rename_column :users, :username, :full_name
  end
end
