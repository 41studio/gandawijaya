# == Schema Information
#
# Table name: offer_rooms
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :integer
#  shop_id    :integer
#  offerer    :string
#  user_id    :integer
#

class OfferRoom < ActiveRecord::Base
  has_many   :offers, dependent: :destroy

  belongs_to :product
  delegate :name, to: :product, allow_nil: :true, prefix: true
  belongs_to :shop
  delegate :id, :name, to: :shop, allow_nil: true, prefix: true
  belongs_to :user
  delegate :username, :id, :email, :image, to: :user, allow_nil: true, prefix: true

  scope :newest, -> { order('created_at DESC') }
end
