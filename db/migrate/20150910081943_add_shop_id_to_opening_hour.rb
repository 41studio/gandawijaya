class AddShopIdToOpeningHour < ActiveRecord::Migration
  def change
    add_column :opening_hours, :shop_id, :integer
  end
end
