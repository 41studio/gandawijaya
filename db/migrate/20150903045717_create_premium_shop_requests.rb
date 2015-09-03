class CreatePremiumShopRequests < ActiveRecord::Migration
  def change
    create_table :premium_shop_requests do |t|
      t.boolean :approved

      t.timestamps null: false
    end
  end
end
