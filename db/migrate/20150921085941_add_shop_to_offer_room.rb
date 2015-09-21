class AddShopToOfferRoom < ActiveRecord::Migration
  def change
    add_reference :offer_rooms, :shop, index: true, foreign_key: true
  end
end
