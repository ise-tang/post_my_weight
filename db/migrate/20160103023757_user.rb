class User < ActiveRecord::Migration
  def change
    add_column :users, :update_name, :boolean, default: true
  end
end
