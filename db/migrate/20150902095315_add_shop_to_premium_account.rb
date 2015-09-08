class AddShopToPremiumAccount < ActiveRecord::Migration
  def change
    add_reference :premium_accounts, :shop, index: true, foreign_key: true
  end
end
