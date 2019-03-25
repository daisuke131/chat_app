class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
         has_many :messages, dependent: :destroy
         has_many :rooms, dependent: :destroy
         validates :user_name, presence: true
         mount_uploader :user_image, UserImageUploader
end