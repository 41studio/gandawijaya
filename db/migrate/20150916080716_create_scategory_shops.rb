class CreateScategoryShops < ActiveRecord::Migration
  def change
    create_table :scategory_shops do |t|

      t.timestamps null: false
    end
  end
end
