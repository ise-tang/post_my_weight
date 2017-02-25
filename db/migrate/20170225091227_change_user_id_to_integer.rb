class ChangeUserIdToInteger < ActiveRecord::Migration
  def change
    change_column :measurements, :user_id, :integer, using: "CAST(user_id AS INTEGER)"
  end
end
