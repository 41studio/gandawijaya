class DropTablePremiumAccounts < ActiveRecord::Migration
  def change
    drop_table :premium_accounts
  end
end
