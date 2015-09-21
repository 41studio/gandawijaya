class CreateOfferRooms < ActiveRecord::Migration
  def change
    create_table :offer_rooms do |t|

      t.timestamps null: false
    end
  end
end
