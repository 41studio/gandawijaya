class ChangeTypeDataPriceProduct < ActiveRecord::Migration
  def change
    change_column :products, :price, :integer
  end
end
