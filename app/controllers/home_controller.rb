class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @habits_count = current_user.habits_count
    @habits = current_user.habits
    @not_performed_habits = current_user.habits.not_performed.count
    @completed_habits = current_user.habits.completed.count
    @in_progress_habits = current_user.habits.in_progress.count
    @days_registered = current_user.days_registered
  end
end
