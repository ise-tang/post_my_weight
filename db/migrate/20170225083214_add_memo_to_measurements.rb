class AddMemoToMeasurements < ActiveRecord::Migration
  def change
    add_column :measurements, :memo, :text

  end
end
