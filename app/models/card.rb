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

  before_create :set_default_attributes

  def check_translation(translation)
    if translated_text == translation
      update_review_date
    else
      update_attempt_count
    end
  end

  private

  def new_review_date
    case box_number
    when 1
      Time.now + 12.hours
    when 2
      Time.now + 3.days
    when 3
      Time.now + 7.days
    when 4
      Time.now + 14.days
    else
      Time.now + 1.month
    end
  end

  def update_review_date
    update_attributes(attempt: 0, review_date: new_review_date, box_number: [box_number + 1, 6].min)
    true
  end

  def update_attempt_count
    if attempt == 2
      update_attributes(review_date: Time.now + 12.hours,
                        box_number: 1,
                        attempt: 0)
    else
      increment!(:attempt)
    end
    false
  end

  def set_default_attributes
    self.review_date = Time.now
    self.box_number = 1
    self.attempt = 0
  end

  def original_and_translated_not_equal
    if translated_text == original_text
      errors.add(:translated_text, "не может быть такой же как оригинал")
    end
  end
end
