class RemoveCardAttachement < ActiveRecord::Migration
  def up
    remove_attachment :cards, :card_photo
  end

  def down
    change_table :cards do |t|
      t.attachment :card_photo
    end
  end
end
