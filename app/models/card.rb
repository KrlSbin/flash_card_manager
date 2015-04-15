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

  before_create :set_review_date, :set_box_number

  def check_translation(translation)
    if translated_text == translation
      case box_number
      when 1
        update_attributes(review_date: Time.now + 12.hours, box_number: 2)
      when 2
        update_attributes(review_date: Time.now + 3.days, box_number: 3)
      when 3
        update_attributes(review_date: Time.now + 7.days, box_number: 4)
      when 4
        update_attributes(review_date: Time.now + 14.days, box_number: 5)
      when 5
        update_attributes(review_date: Time.now + 1.month, box_number: 6)
      when 6
        update_attributes(review_date: Time.now + 1.month)
      end
      return true
    else
      case attempt
      when 0
        update_attributes(attempt: 1)
      when 1
        update_attributes(attempt: 2)
      when 2
        update_attributes(review_date: Time.now + 12.hours,
                          box_number: 1,
                          attempt: 0)
      end
      return false
    end
  end

  private

  def set_review_date
    self.review_date = Time.now
  end

  def set_box_number
    self.box_number = 1
  end

  def original_and_translated_not_equal
    if translated_text == original_text
      errors.add(:translated_text, "не может быть такой же как оригинал")
    end
  end
end
