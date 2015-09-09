class AddAcceptProductToProducts < ActiveRecord::Migration
  def change
    add_column :products, :accept_product, :boolean, :default => false
  end
end
