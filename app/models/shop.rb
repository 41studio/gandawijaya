# == Schema Information
#
# Table name: shops
#
#  id          :integer          not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  image       :string
#  description :text
#

require 'elasticsearch/model'

class Shop < ActiveRecord::Base
  enum status: [:under_review, :on_progress, :approved]
  extend FriendlyId
  friendly_id :name_and_id, use: [:slugged, :finders]
  mount_uploader :image, GalleryUploader
  belongs_to :user
  searchkick word_start: [:name]

  acts_as_votable
  has_many :premium_shop_requests
  has_one :premium_account
  has_many :reviews, as: :reviewable
  has_many :products, dependent: :destroy
  belongs_to :user
  after_save :send_mail_new_shop

  def send_mail_new_shop
    ShopMailer.shop_created(self.user).deliver_now
  end
  def name_and_id
    "#{name}  #{id}#{Time.now.strftime("%Y%m%d")}"
  end

  def should_generate_new_friendly_id?
    name_changed? || super
  end

  def self.search_kick(query)
    search query, fields: [{name: :word_start}]
  end
end
