class CreatePremiumAccounts < ActiveRecord::Migration
  def change
    create_table :premium_accounts do |t|
      t.string :url

      t.timestamps null: false
    end
  end
end
