class CreateWeights < ActiveRecord::Migration
  def change
    create_table :weights do |t|
      t.float :weight
      t.string :user_id

      t.timestamps null: false
    end
  end
end
