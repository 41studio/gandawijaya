class RemoveAcceptShopFromShops < ActiveRecord::Migration
  def change
    remove_column :shops, :accept_shop, :boolean
  end
end
