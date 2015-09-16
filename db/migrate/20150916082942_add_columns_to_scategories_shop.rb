class AddColumnsToScategoriesShop < ActiveRecord::Migration
  def change
    add_reference :scategory_shops, :shop, index: true, foreign_key: true
    add_reference :scategory_shops, :scategory, index: true, foreign_key: true
  end
end
