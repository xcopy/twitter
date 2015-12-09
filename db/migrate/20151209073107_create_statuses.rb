class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.references :user, index: true, foreign_key: false
      t.text :text

      t.timestamps null: false
    end
  end
end
