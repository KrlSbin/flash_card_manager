# frozen_string_literal: true
class AddEmailAndPasswordToUser < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.text :email
      t.text :password
      t.timestamps
    end
  end
end
