class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :name              , null: false
      t.text :description
      t.integer :created_by_id  , null: false
      t.integer :group_id
      t.integer :location_id    , null: false
      t.datetime :start_time    , null: false
      t.integer :duration

      t.timestamps
    end
  end
end
