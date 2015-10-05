class AddUserToOfferRoom < ActiveRecord::Migration
  def change
    add_reference :offer_rooms, :user, index: true, foreign_key: true
  end
end
