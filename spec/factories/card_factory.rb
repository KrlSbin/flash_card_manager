FactoryGirl.define do
  factory :user do
    email "kirill@mail.ru"
    password "1234"
    password_confirmation "1234"
  end

  factory :card do
    user
    original_text "card"
    translated_text "карточка"
    review_date Time.now
  end
end
