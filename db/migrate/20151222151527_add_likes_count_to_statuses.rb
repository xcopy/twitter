class AddLikesCountToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :likes_count, :integer, default: 0
  end
end
