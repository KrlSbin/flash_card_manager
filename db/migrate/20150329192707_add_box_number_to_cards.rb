# frozen_string_literal: true
class AddBoxNumberToCards < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :box_number, :integer
  end
end
