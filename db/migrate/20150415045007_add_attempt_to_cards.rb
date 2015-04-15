class AddAttemptToCards < ActiveRecord::Migration
  def change
    add_column :cards, :attempt, :integer
  end
end
