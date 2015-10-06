# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string
#  price       :integer
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  shop_id     :integer
#  slug        :string
#  user_id     :integer
#  status      :integer          default(0)
#

class Product < ActiveRecord::Base
  extend FriendlyId
  is_impressionable
  acts_as_votable

  friendly_id :name, use: [:slugged, :finders]
  enum status: [:under_review, :on_progress, :approved]

  has_many   :galleries,   dependent: :destroy
  has_many   :reviews,     dependent: :destroy,  as: :reviewable
  has_many   :offer_rooms, dependent: :destroy

  belongs_to :shop
  belongs_to :user

  delegate :id, :name, to: :shop, allow_nil: true, prefix: true
  delegate :id, :username, :image, to: :shop, allow_nil: true, prefix: true

  accepts_nested_attributes_for :galleries, allow_destroy: true

  validates :name, presence: true
  validates :price, presence: true

  after_create :sendmail_create_product

  def sendmail_create_product
    ProductMailer.product_created(self.user).deliver
  end

end
