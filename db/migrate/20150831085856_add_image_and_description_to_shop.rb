class AddImageAndDescriptionToShop < ActiveRecord::Migration
  def change
    add_column :shops, :image, :string
    add_column :shops, :description, :text
  end
end
