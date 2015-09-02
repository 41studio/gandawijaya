class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :image, AvatarUploader
  devise :database_authenticatable, :registerable,
<<<<<<< HEAD
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :twitter, :google_oauth2]
  has_many :reviews, dependent: :destroy
  has_many :shops, dependent: :destroy
  has_many :products

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
=======
         :recoverable, :rememberable, :trackable, :validatable

  has_many :products
  has_many :shops       
>>>>>>> ea7e43efc95cbdd9dcb5931289b42d8e42278e97
end
