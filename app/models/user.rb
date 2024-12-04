class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  has_many :habits



  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def days_registered
    (Date.current - created_at.to_date).to_i
  end

  def habits_count
    habits.count
  end
end
