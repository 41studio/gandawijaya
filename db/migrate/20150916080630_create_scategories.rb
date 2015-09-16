class CreateScategories < ActiveRecord::Migration
  def change
    create_table :scategories do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
