class ChangeUserIdToInteger < ActiveRecord::Migration
  def change
    change_column :measurements, :user_id, :integer
  end
end
