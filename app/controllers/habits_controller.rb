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
      redirect_to @habit, notice: "Новая привычка добавлена"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @habit.update(habit_params)
      redirect_to @habit, notice: "Привычка обновлена."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @habit.destroy
      redirect_to habits_path, status: :see_other, notice: "Привычка удалена"
    else
      redirect_to habits_path, alert: "Упс. Не удалось удалить", status: :unprocessable_entity
    end
  end


  def complete
    if @habit.set_status('completed')
      redirect_to @habit, notice: 'Статус привычки обновлен на "завершено".'
    else
      redirect_to @habit, alert: 'Не удалось обновить статус.'
    end
  end
  

  private

  def set_habit
    @habit = current_user&.habits&.find_by(id: params[:id])
    redirect_to habits_path, alert: "Привычка не найдена или у вас нет прав." if @habit.nil?
  end

  def habit_params
    params.require(:habit).permit(:title, :description, :tags, :status, :send_at, :user_id)
  end
end
