class AddContactMessageToComments < ActiveRecord::Migration[7.1]
  def change
    add_reference :comments, :contact_message, null: false, foreign_key: true
  end
end
