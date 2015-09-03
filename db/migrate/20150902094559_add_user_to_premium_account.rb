class AddUserToPremiumAccount < ActiveRecord::Migration
  def change
    add_reference :premium_accounts, :user, index: true, foreign_key: true
  end
end
