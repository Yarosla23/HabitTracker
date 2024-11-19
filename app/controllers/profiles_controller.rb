class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    render :show
  end

  def edit
    @user = current_user
    render :edit
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path, notice: 'Профиль успешно обновлен.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :birthday_date, :options)
  end
end
