class AddShopToPremiumShopRequest < ActiveRecord::Migration
  def change
    add_reference :premium_shop_requests, :shop, index: true, foreign_key: true
  end
end
