class DropTableShopAndProduct < ActiveRecord::Migration
  def change
    drop_table :shops
    drop_table :products
  end
end
