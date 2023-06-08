FactoryBot.define do
  factory :user, class: User do
    email { 'kirill@gmail.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
