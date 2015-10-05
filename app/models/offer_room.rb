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
#

class OfferRoom < ActiveRecord::Base
  has_many   :offers, dependent: :destroy
  belongs_to :product
  belongs_to :shop
  belongs_to :user

  scope :newest, -> { order('created_at DESC') }
end
