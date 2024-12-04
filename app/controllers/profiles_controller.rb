class ProfilesController < ApplicationController
  before_action :set_user, only: [:new, :create, :show, :edit]

  before_action :authenticate_user!

  def connect_telegram
    current_user.update!(telegram_token: SecureRandom.hex(10))
    @telegram_link = "https://t.me/habitd_tracker_bot?start=#{current_user.telegram_token}"
  end

  def show
    @user = current_user
    @profile = @user.profile || @user.build_profile
    @days_registered = @user.days_registered
    @habits_count = @user.habits_count

    if @user.telegram_token.present?
      @telegram_link = "https://t.me/habitd_tracker_bot?start=#{@user.telegram_token}"
    else
      connect_telegram
    end
    render :show
  end


  def new
    @profile = @user.build_profile
  end

  def create
    @profile = @user.build_profile(profile_params)

    if @profile.save
      redirect_to user_profile_path(@user), notice: 'Profile was successfully created.'
    else
      render :new
    end
  end

  def edit
    @profile = @user.profile
  end

  def update
    @profile = @user.profile

    if @profile.update(profile_params)
      redirect_to user_profile_path(@user), notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end


  private

  def set_user
    @user = User.find_by(id: params[:user_id]) || current_user
    redirect_to root_path, alert: "User not found." unless @user
  end

  def profile_params
    params.require(:profile).permit(:avatar, :username, :birthday_date, :options)
  end
end
