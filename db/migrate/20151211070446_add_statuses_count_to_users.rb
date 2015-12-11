class AddStatusesCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :statuses_count, :integer, default: 0
  end
end
