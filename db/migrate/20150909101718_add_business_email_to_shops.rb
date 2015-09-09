class AddBusinessEmailToShops < ActiveRecord::Migration
  def change
    add_column :shops, :business_email, :string
  end
end
