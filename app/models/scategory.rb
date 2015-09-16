class Scategory < ActiveRecord::Base
  searchkick
  has_many :scategory_shops
  has_many :shops, through: :scategory_shops
end

Scategory.reindex

