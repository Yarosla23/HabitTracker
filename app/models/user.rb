class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  has_many :habits


  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
