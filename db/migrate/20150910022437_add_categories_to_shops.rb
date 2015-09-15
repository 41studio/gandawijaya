class AddCategoriesToShops < ActiveRecord::Migration
  def change
    add_column :shops, :categories, :string
  end
end
