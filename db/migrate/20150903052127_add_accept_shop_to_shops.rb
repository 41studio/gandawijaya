class AddAcceptShopToShops < ActiveRecord::Migration
  def change
    add_column :shops, :accept_shop, :boolean, :default => false
  end
end
