class AddAttachmentCardPhotoToCards < ActiveRecord::Migration
  def self.up
    change_table :cards do |t|
      t.attachment :card_photo
    end
  end

  def self.down
    remove_attachment :cards, :card_photo
  end
end
