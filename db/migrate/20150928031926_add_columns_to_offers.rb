class AddColumnsToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :read_by_offerer, :boolean
    add_column :offers, :read_by_owner, :boolean
  end
end
