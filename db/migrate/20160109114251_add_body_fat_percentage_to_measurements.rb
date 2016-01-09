class AddBodyFatPercentageToMeasurements < ActiveRecord::Migration
  def change
    add_column :measurements, :body_fat_percentage, :float
  end
end
