class HabitsController < ApplicationController
  before_action :set_habit, only: %i[show edit update destroy]

  def index
    @habits = current_user&.habits || []
  end

  def show; end

  def new
    @habit = current_user&.habits&.new || Habit.new
  end

  def edit; end

  def create
    @habit = current_user&.habits&.new(habit_params)

    if @habit&.save
      redirect_to @habit, notice: "Habit was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @habit.update(habit_params)
      redirect_to @habit, notice: "Habit was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @habit.destroy
      redirect_to habits_path, status: :see_other, notice: "Habit was successfully destroyed."
    else
      redirect_to habits_path, alert: "Failed to delete habit.", status: :unprocessable_entity
    end
  end

  private

  def set_habit
    @habit = current_user&.habits&.find_by(id: params[:id])
    redirect_to habits_path, alert: "Habit not found or you do not have access." unless @habit
  end

  def habit_params
    params.require(:habit).permit(:title, :description, :tags, :image)
  end
end
