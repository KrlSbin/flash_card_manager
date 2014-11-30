class Card < ActiveRecord::Base
  validates :original_text, :translated_text, presence: true
  validate :original_and_translated_not_equal

  def original_and_translated_not_equal
    errors.add(:translated_text, "can't be the same as original") if translated_text == original_text
  end
end
