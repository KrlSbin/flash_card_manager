FactoryGirl.define do
  factory :card do
    original_text "card"
    translated_text "карточка"
    review_date	Time.now
  end
end
