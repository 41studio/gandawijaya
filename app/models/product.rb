# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string
#  price       :decimal(8, 2)
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
  acts_as_commentable

  friendly_id :name, use: [:slugged, :finders]
  enum status: [:under_review, :on_progress, :approved]

  has_many   :galleries, dependent: :destroy
  has_many   :reviews, as: :reviewable
  has_many   :offers
  has_many   :offer_rooms
  belongs_to :shop
  belongs_to :user

  accepts_nested_attributes_for :galleries, allow_destroy: true

  validates :name, presence: true
  validates :price, presence: true

  after_create :sendmail_create_product

  def sendmail_create_product
    ProductMailer.product_created(self.user).deliver
  end

end
