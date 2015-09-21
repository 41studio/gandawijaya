class AddProductToOfferRoom < ActiveRecord::Migration
  def change
    add_reference :offer_rooms, :product, index: true, foreign_key: true
  end
end
