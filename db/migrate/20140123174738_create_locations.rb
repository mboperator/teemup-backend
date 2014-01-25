class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.float :lat
      t.float :lon
      t.point :lonlat, geographic: true
      t.timestamps
    end
    add_index :locations, :lonlat, spatial: true
  end
end
