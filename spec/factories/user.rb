FactoryBot.define do
  factory :user do
    email {  'user@example.com' }
    password { 'password123' }
    name { 'JohnDoe' }
    status { 'active' }
    chat_id { Faker::Number.number(digits: 10) }
    telegram_token { Faker::Alphanumeric.alphanumeric(number: 20) }
    provider { nil }
    uid { nil }
  end
end
