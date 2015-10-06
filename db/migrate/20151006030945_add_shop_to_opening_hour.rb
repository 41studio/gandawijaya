class AddShopToOpeningHour < ActiveRecord::Migration
  def change
    add_reference :opening_hours, :shop, index: true, foreign_key: true
  end
end
