class AddColumnToOfferRooms < ActiveRecord::Migration
  def change
    add_column :offer_rooms, :name, :string
    add_column :offer_rooms, :content, :text
    add_column :offer_rooms, :email, :string
    add_column :offer_rooms, :telephone, :string
  end
end
