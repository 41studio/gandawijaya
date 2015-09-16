class ScategoryShop < ActiveRecord::Base
  belongs_to :shop
  belongs_to :scategory
end
