FactoryBot.define do
	factory :habit_track do
		completed { [true, false].sample }
		date { Faker::Date.backward(days: 7) }
		association :habit
	end
end
	