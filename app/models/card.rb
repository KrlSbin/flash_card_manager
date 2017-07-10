# == Schema Information
#
# Table name: cards
#
#  id              :integer          not null, primary key
#  original_text   :text
#  translated_text :text
#  review_date     :datetime
#  created_at      :datetime
#  updated_at      :datetime
#  user_id         :integer
#  deck_id         :integer
#  box_number      :integer
#  attempt         :integer
#
# Indexes
#
#  index_cards_on_deck_id  (deck_id)
#  index_cards_on_user_id  (user_id)
#

class Card < ActiveRecord::Base
  belongs_to :deck, class_name: Deck, foreign_key: :deck_id
  belongs_to :user, class_name: User, foreign_key: :user_id

  scope :for_review, -> { where('review_date <= ?', Time.now).order('RANDOM()') }

  validates_presence_of :original_text, :translated_text, :deck
  validate :original_and_translated_not_equal

  before_create :set_default_attributes

  def check_translation(user_translation)
    typos_count = levenshtein_distance(user_translation)

    if translated_text == user_translation
      update_review_date
      success = true
    else
      update_attempt_count
      success = false
    end

    { success: success, typos_count: typos_count }
  end

  def levenshtein_distance(user_translation)
    DamerauLevenshtein.distance(user_translation, translated_text)
  end

  # todo move to service
  def self.mail_cards_to_review
    # todo move to scope
    User.joins(:cards).where('review_date <= ?', Time.now).uniq.each do |user|
      CardMailer.cards_to_review(user).deliver_now
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
    update_attributes(attempt: 0,
                      review_date: new_review_date,
                      box_number: next_box_number)
  end

  def next_box_number
    return 6 if box_number == 6
    box_number + 1
  end

  # move to service
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

  # todo refactor to validation
  def original_and_translated_not_equal
    errors.add(:translated_text, 'could not be the same as original.') if translated_text == original_text
  end
end
