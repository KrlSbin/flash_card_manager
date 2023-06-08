class SorceryCore < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :salt, :string
    change_column :users, :email, :string
    change_column :users, :password, :string
    rename_column :users, :password, :crypted_password
    add_index :users, :email, unique: true
  end
end
