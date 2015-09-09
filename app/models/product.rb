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
#

class Product < ActiveRecord::Base
  enum status: [:under_review, :on_progress, :approved]
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  is_impressionable

  has_many  :galleries, dependent: :destroy
  has_many  :reviews, as: :reviewable
  belongs_to :shop
  belongs_to :user
  acts_as_commentable
  acts_as_votable
  accepts_nested_attributes_for :galleries, allow_destroy: true
  after_create :sendmail_create_product

  def sendmail_create_product
    ProductMailer.product_created(self.user).deliver
  end

end
