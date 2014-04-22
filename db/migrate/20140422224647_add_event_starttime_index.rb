class AddEventStarttimeIndex < ActiveRecord::Migration
  def change
    add_index :events, :start_time
    add_index :events, :daily_event
    add_index :events, :weekly_event
  end
end
