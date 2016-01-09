class RenameWeightsToMeasurements < ActiveRecord::Migration
  def change
    rename_table :weights, :measurements
  end
end
