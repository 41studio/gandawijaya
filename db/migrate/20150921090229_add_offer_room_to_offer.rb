class AddOfferRoomToOffer < ActiveRecord::Migration
  def change
    add_reference :offers, :offer_room, index: true, foreign_key: true
  end
end
