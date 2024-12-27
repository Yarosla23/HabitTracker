class HabitTracksController < ApplicationController
  before_action :set_habit

  def create
    @habit_track = @habit.habit_tracks.new(habit_track_params)
    if @habit_track.save
      respond_to do |format|
        format.html { redirect_to @habit, notice: 'Трекер привычек был добавлен.' }
        format.js   
      end
    else
      respond_to do |format|
        format.html { redirect_to @habit, alert: 'Error adding habit track.' }
        format.js   { render 'error.js.erb' }
      end
    end
  end

  def update
    @habit_track = @habit.habit_tracks.find(params[:id])
    if @habit_track.update(habit_track_params)
      respond_to do |format|
        format.html { redirect_to @habit, notice: 'Трекер привычек обновлен' }
        format.js   # Для динамического обновления календаря
      end
    else
      respond_to do |format|
        format.html { redirect_to @habit, alert: 'Error updating habit track.' }
        format.js   { render 'error.js.erb' }
      end
    end
  end

  private

  def set_habit
    @habit = current_user.habits.find(params[:habit_id])
  end

  def habit_track_params
    params.require(:habit_track).permit(:date, :completed)
  end
end
