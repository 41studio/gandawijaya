class AddImageToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :image, :string
  end
end
