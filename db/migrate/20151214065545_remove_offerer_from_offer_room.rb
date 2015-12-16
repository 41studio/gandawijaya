class RemoveOffererFromOfferRoom < ActiveRecord::Migration
  def change
    remove_column :offer_rooms, :offerer, :string
  end
end
