class Card < ActiveRecord::Base
  belongs_to :deck
  belongs_to :user
  has_attached_file :card_photo, styles: { medium: "360x360" }
  validates_attachment_content_type :card_photo,
                                    content_type: ["image/jpg", "image/jpeg",
                                                   "image/png", "image/gif"]

  scope :for_review, -> { where("review_date <= ?", Time.now).order("RANDOM()") }

  validates :original_text, :translated_text, :deck_id, presence: true
  validate :original_and_translated_not_equal

  before_create :set_review_date

  def check_translation(translation)
    if translated_text == translation
      update_attribute(:review_date, Time.now + 3.days)
      return true
    else
      return false
    end
  end

  private

  def set_review_date
    self.review_date = Time.now
  end

  def original_and_translated_not_equal
    if translated_text == original_text
      errors.add(:translated_text, "не может быть такой же как оригинал")
    end
  end
end
