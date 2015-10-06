class RemoveTablePremiumAccountRequest < ActiveRecord::Migration
  def change
    drop_table :premium_shop_requests
  end
end
