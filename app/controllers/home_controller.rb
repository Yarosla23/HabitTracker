class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @habits_count = current_user.habits_count
    @days_registered = current_user.days_registered
  end
end
