FactoryGirl.define do
  factory :user do
    email "kirills@mail.ru"
    password "1234"
    password_confirmation "1234"
  end

  factory :deck do
    user
    name "current deck"
    default "true"
  end

  factory :card do
    deck
    original_text "card"
    translated_text "карточка"
    review_date Time.now
  end
end
