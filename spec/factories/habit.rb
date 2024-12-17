FactoryBot.define do
  factory :habit do
    title { 'Стать крутым' }
    description {'A short description of the habit.'}
    tags { 'Здоровье' } 
    image { Faker::Internet.url }
    send_at { Time.now + 1.day }
    status { 'Не выполняется' }
    association :user
  end
end
