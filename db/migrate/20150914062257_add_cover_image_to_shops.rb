class AddCoverImageToShops < ActiveRecord::Migration
  def change
    add_column :shops, :cover_image, :string
  end
end
