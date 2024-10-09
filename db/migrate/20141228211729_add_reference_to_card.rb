# frozen_string_literal: true
class AddReferenceToCard < ActiveRecord::Migration[7.0]
  def change
    add_reference :cards, :user, index: true
  end
end
