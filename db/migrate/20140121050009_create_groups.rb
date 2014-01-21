class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.text :name, null: false
      t.text :description
      t.integer :created_by_id, null: false
      t.timestamps
    end
  end
end
