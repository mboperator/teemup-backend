class CreateEventInvites < ActiveRecord::Migration
  def change
    create_table :event_invites do |t|
      t.integer :user_id,       null: false
      t.integer :event_id,      null: false
      t.boolean :is_admin,      default: false
      t.boolean :is_confirmed,  default: false

      t.timestamps
    end
  end
end
