class RemoveAcceptProductFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :accept_product, :boolean
  end
end
