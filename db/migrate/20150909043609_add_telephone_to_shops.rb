class AddTelephoneToShops < ActiveRecord::Migration
  def change
    add_column :shops, :telephone, :string
  end
end
