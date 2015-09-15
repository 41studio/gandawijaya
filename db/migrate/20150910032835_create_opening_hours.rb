class CreateOpeningHours < ActiveRecord::Migration
  def change
    create_table :opening_hours do |t|
      t.integer :day_work
      t.integer :start_work
      t.integer :end_work

      t.timestamps null: false
    end
  end
end
