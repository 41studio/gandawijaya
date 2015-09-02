class RenameColumnRate < ActiveRecord::Migration
  def change
    rename_column :reviews, :rate, :rate_point
  end
end
