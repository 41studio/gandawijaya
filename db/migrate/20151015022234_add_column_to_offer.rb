class AddColumnToOffer < ActiveRecord::Migration
  def change
    add_column :offer_rooms, :name, :string
    add_column :offer_rooms, :content, :text
    add_column :offer_rooms, :email, :string
    add_column :offer_rooms, :telephone, :integer
  end
end
