class AddStatusToPremiumAccount < ActiveRecord::Migration
  def change
    add_column :premium_accounts, :status, :boolean, default: false
  end
end
