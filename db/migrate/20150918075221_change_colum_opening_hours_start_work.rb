class ChangeColumOpeningHoursStartWork < ActiveRecord::Migration
  def change
    change_column :opening_hours, :start_work, :string
    change_column :opening_hours, :end_work, :string
  end
end
