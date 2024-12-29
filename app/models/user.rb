class User < ApplicationRecord
  
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :omniauthable, omniauth_providers: [:telegram]
  
  has_one :profile, dependent: :destroy
  has_many :habits
  
  def self.from_omniauth(auth)
    user = User.where(telegram_id: auth.uid).first_or_initialize
    user.telegram_id = auth.uid
    user.name = auth.info.username
    user.save
    user
  end


  def days_registered
    (Date.current - created_at.to_date).to_i
  end

  def habits_count
    habits.count
  end

  private

  def password_present?
    password.present?
  end
end
