class DropTableShopAndProduct < ActiveRecord::Migration
  def change
    drop_table :products
    drop_table :shops
  end
end
