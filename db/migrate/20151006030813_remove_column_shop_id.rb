class RemoveColumnShopId < ActiveRecord::Migration
  def change
    remove_column :opening_hours, :shop_id
  end
end
