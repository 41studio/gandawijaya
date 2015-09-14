# == Schema Information
#
# Table name: premium_shop_requests
#
#  id         :integer          not null, primary key
#  approved   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  shop_id    :integer
#

class PremiumShopRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :shop
end
