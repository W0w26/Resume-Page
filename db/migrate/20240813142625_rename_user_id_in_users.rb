class RenameUserIdInUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :user_id,:uid
  end
end
