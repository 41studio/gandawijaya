class AddBusinessNameToShops < ActiveRecord::Migration
  def change
    add_column :shops, :bussines_name, :string
  end
end
