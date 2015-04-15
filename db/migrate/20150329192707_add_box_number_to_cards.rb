class AddBoxNumberToCards < ActiveRecord::Migration
  def change
    add_column :cards, :box_number, :integer
  end
end
