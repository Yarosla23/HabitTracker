class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @habits = current_user.habits
    @habits_count = current_user.habits_count 
    @days_registered = current_user.days_registered

    @completed_habits = current_user.habits.completed.count
    @in_progress_habits = current_user.habits.in_progress.count
    @not_performed_habits = current_user.habits.not_performed.count
  end
end
