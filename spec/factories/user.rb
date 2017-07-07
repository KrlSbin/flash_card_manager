FactoryGirl.define do
  factory :user, class: User do
    email 'kirill@mail.ru'
    password 'password'
    password_confirmation 'password'
  end
end
