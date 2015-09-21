class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.text :content

      t.timestamps null: false
    end
  end
end
