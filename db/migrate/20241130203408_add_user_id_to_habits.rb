class AddUserIdToHabits < ActiveRecord::Migration[7.0]
  Habit.delete_all
  def change
    add_reference :habits, :user, null: false, foreign_key: true
  end
end
