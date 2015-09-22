# == Schema Information
#
# Table name: offer_rooms
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  product_id :integer
#  shop_id    :integer
#

class OfferRoom < ActiveRecord::Base
  has_many   :offers, dependent: :destroy
  belongs_to :product
  belongs_to :shop
  belongs_to :user
end