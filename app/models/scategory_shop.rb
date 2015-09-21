# == Schema Information
#
# Table name: scategory_shops
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  shop_id      :integer
#  scategory_id :integer
#

class ScategoryShop < ActiveRecord::Base
  belongs_to :shop
  belongs_to :scategory
end
