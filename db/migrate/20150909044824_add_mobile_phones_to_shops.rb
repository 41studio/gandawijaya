class AddMobilePhonesToShops < ActiveRecord::Migration
  def change
    add_column :shops, :mobile_phones, :string
  end
end
