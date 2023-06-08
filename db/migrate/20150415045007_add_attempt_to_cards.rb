class AddAttemptToCards < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :attempt, :integer
  end
end
