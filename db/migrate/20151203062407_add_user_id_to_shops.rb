class AddUserIdToShops < ActiveRecord::Migration
  def change
    add_column :shops, :user_id, :integer
    add_index :shops, :user_id
  end
end
