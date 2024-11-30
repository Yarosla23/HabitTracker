class User < ApplicationRecord
  has_many :habits

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
