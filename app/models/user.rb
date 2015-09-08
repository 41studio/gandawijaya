class User < ActiveRecord::Base
  enum gender: [:Male, :Female]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :image, AvatarUploader
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  has_many :premium_shop_requests, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :shops, dependent: :destroy
  has_many :products
  has_many :shops 
  has_many :comments 
  mount_uploader :image, GalleryUploader     
end
