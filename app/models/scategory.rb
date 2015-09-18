class Scategory < ActiveRecord::Base
  has_many :scategory_shops
  has_many :shops, through: :scategory_shops
end

