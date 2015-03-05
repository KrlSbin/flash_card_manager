FactoryGirl.define do
  factory :user do
    email "kirill@mail.ru"
    password "1234"
    password_confirmation "1234"
  end

  factory :deck do
    name "current deck"
    default false
  end

  factory :card do
    original_text "card"
    translated_text "карточка"
    review_date Time.now
  end
end
