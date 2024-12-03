class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  has_many :habits



  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
