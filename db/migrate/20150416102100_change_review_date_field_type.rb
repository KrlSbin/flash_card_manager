class ChangeReviewDateFieldType < ActiveRecord::Migration[7.0]
  def change
    change_column :cards, :review_date, :datetime
  end
end
