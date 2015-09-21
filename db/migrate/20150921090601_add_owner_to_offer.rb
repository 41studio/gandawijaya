class AddOwnerToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :owner, :string
  end
end
