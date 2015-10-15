class AddColumnsToShop < ActiveRecord::Migration
  def change
    add_column :shops, :account_status, :boolean
    add_column :shops, :url, :string
  end
end
