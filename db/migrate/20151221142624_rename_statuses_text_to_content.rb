class RenameStatusesTextToContent < ActiveRecord::Migration
  def up
    rename_column :statuses, :text, :content
  end

  def down
    rename_column :statuses, :content, :text
  end
end
