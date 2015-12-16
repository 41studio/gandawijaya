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
  belongs_to :shop
  belongs_to :user

  delegate :name, to: :product, allow_nil: :true, prefix: true
  delegate :id, :name, :business_email, :user_id, to: :shop, allow_nil: true, prefix: true
  delegate :username, :id, :email, :image, :handphone, :first_name, :last_name, to: :user, allow_nil: true, prefix: true

  scope :newest, -> { order('created_at DESC') }

  def self.find_if_any_or_initialize_by(param_offers)
    where(shop_id:    param_offers[:shop_id],
          product_id: param_offers[:product_id],
          user_id:    param_offers[:user_id]
          ).first_or_initialize do |offer|
            offer.email     = param_offers[:email]
            offer.name      = param_offers[:name]
            offer.telephone = param_offers[:phone]
            offer.content   = param_offers[:content]
            offer.user_id   = param_offers[:user_id]
					end
  end
end
