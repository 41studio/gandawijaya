# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string
#  first_name             :string
#  last_name              :string
#  neighborhood           :string
#  address                :text
#  image                  :string
#  gender                 :integer
#  birthday               :date
#  subscribe              :boolean
#  handphone              :string
#  term_of_user           :boolean
#  status                 :string
#  last_ip                :string
#  user_agent             :string
#  provider               :string
#  uid                    :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#

class User < ActiveRecord::Base
  mount_uploader :image, AvatarUploader

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  enum gender: [:Male, :Female]

  has_many :reviews,          dependent: :destroy
  has_many :shops,            dependent: :destroy
  has_many :products
  has_many :premium_accounts, dependent: :destroy
  has_many :comments
  has_many :offers          , dependent: :destroy

  validates :handphone, numericality: { allow_blank: true }
  validates :username,  format: { with: /\A[a-zA-Z0-9 ]+\Z/, allow_blank: true },
                        length: { within: 2..40,
                                  too_short: 'too short name',
                                  too_long: 'too long name',
                                  allow_blank: true
                                }

  validates :term_of_user, acceptance: { accept: true }
  validates :first_name, :last_name, :address, presence: true

  def self.from_omniauth(auth, user_agent)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email.present? ? auth.info.email : "#{auth.info.first_name}#{auth.info.last_name}@mail.com"
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name
      user.address = "No address given"
      user.skip_confirmation!
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.remote_image_url = auth.info.image
      user.user_agent = user_agent
    end
  end

end
