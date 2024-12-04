class Profile < ApplicationRecord
  belongs_to :user
  mount_uploader :avatar, AvatarUploader

  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }
end
