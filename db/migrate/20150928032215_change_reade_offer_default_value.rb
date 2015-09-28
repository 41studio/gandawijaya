class ChangeReadeOfferDefaultValue < ActiveRecord::Migration
  def change
    change_column :offers, :read_by_offerer, :boolean, default: false
    change_column :offers, :read_by_owner, :boolean, default: false
  end
end
