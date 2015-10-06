class DropOverallAverages < ActiveRecord::Migration
  def change
    drop_table :overall_averages
  end
end
