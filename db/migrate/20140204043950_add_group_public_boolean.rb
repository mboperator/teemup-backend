class AddGroupPublicBoolean < ActiveRecord::Migration
  def change
    add_column :groups, :is_public, :boolean, default: false
  end
end
