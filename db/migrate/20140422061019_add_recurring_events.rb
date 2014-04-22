class AddRecurringEvents < ActiveRecord::Migration
  def change
    add_column :events, :daily_event, :boolean, default: false
    add_column :events, :weekly_event, :boolean, default: false
  end
end
