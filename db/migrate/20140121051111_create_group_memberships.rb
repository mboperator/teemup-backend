class CreateGroupMemberships < ActiveRecord::Migration
  def change
    create_table :group_memberships do |t|
      t.integer :group_id, null: false
      t.integer :user_id, null: false
      t.boolean :is_admin, default: false
      t.boolean :is_confirmed, default: false

      t.timestamps
    end
  end
end
