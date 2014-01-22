class CreateEventInvites < ActiveRecord::Migration
  def change
    create_table :event_invites do |t|
      t.integer :user_id
      t.integer :event_id
      t.boolean :is_admin
      t.boolean :is_confirmed

      t.timestamps
    end
  end
end
