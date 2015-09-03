class AddUserToPremiumShopRequest < ActiveRecord::Migration
  def change
    add_reference :premium_shop_requests, :user, index: true, foreign_key: true
  end
end
