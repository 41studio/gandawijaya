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
  has_many :premium_accounts, dependent: :destroy
  has_many :comments

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email.present? ? auth.info.email : "#{auth.info.first_name}#{auth.info.last_name}@mail.com"
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      # user.remote_image_url = auth.info.image
    end
  end
  def self.from_omniauth_twitter(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name
      # user.first_name = auth.info.first_name
      # user.last_name = auth.info.last_name
      # user.remote_image_url = auth.info.image
      if user.email.blank?
          user.email = "#{auth.uid}@gmail.com"
      end
    end
  end
end
