class AddUserIdToShops < ActiveRecord::Migration
  def change
    add_column :shops, :user_id, :string
  end
end
