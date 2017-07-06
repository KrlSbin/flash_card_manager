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
#  deck_id                 :integer
#  box_number              :integer
#  attempt                 :integer
#

FactoryGirl.define do
  factory :card, class: Card do
    original_text 'sea'
    translated_text 'море'
    review_date nil

    trait :with_deck do
      after(:build) do |record|
        record.deck = create(:deck)
      end
    end
  end
end
