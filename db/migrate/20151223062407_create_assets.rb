class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.references :resource, polymorphic: true, index: true
      t.attachment :attachment

      t.timestamps null: false
    end
  end
end
