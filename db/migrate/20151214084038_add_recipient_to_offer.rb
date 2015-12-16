class AddRecipientToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :recipient, :string
  end
end
