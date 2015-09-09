class AddBusinessNamesToShops < ActiveRecord::Migration
  def change
    add_column :shops, :business_name, :string
  end
end
