class AddOffererToOfferRoom < ActiveRecord::Migration
  def change
    add_column :offer_rooms, :offerer, :string
  end
end
