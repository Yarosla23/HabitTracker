FactoryBot.define do
    factory :profile do
      birthday_date { '01-01-1990' }
      avatar { Faker::Avatar.image }
      username { 'JohnDoe' }
      options { { theme: 'dark', language: 'en' }.to_json }
      association :user
    end
  end
  