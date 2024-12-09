class HabitTrack < ApplicationRecord
  belongs_to :habit

  validates :date, presence: true, uniqueness: { scope: :habit_id }
  validates :completed, inclusion: { in: [true, false] }
end
