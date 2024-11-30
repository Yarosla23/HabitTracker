class ProfilesController < ApplicationController
  before_action :authenticate_user!
  
  def connect_telegram
    current_user.update!(telegram_token: SecureRandom.hex(10)) 
    @telegram_link = "https://t.me/habitd_tracker_bot?start=#{current_user.telegram_token}" 
  end
  def show
    @user = current_user

    if @user.telegram_token.present?
      @telegram_link = "https://t.me/habitd_tracker_bot?start=#{@user.telegram_token}"
    else
      connect_telegram
    end
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
