class Card < ActiveRecord::Base
  validates :original_text, :translated_text, presence: true
  validate :original_and_translated_not_equal

  before_create :set_review_date

  private

  def set_review_date
    self.review_date = Time.now
  end

  def original_and_translated_not_equal
    if translated_text == original_text
      errors.add(:translated_text, "can't be the same as original")
    end
  end
end
