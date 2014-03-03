class AddAttachmentPictureToEvents < ActiveRecord::Migration
  def self.up
    change_table :events do |t|
      t.attachment :picture
    end
  end

  def self.down
    drop_attached_file :events, :picture
  end
end
