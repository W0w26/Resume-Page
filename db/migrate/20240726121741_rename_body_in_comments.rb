class RenameBodyInComments < ActiveRecord::Migration[7.1]
  def change
    rename_column :comments, :comment, :body
  end
end
