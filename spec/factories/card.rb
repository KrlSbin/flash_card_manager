# == Schema Information
#
# Table name: cards
#
#  id                      :integer          not null, primary key
#  original_text           :text
#  translated_text         :text
#  review_date             :datetime
#  created_at              :datetime
#  updated_at              :datetime
#  user_id                 :integer
#  card_photo_file_name    :string
#  card_photo_content_type :string
#  card_photo_file_size    :integer
#  card_photo_updated_at   :datetime
#  deck_id                 :integer
#  box_number              :integer
#  attempt                 :integer
#

FactoryGirl.define do
  factory :deck do
    name "current deck"
  end

  factory :card do
    original_text "card"
    translated_text "карточка"
    review_date Time.now
  end
end
