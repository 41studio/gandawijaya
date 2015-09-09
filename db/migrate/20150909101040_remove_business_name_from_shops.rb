class RemoveBusinessNameFromShops < ActiveRecord::Migration
  def change
    remove_column :shops, :bussines_name, :string
  end
end
