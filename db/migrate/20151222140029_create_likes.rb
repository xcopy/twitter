class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.belongs_to :status
      t.belongs_to :user

      t.timestamps null: false
    end

    add_index :likes, :status_id
    add_index :likes, :user_id
    add_index :likes, [:status_id, :user_id], unique: true
  end
end
