class AddUserIdToRecipients < ActiveRecord::Migration[7.0]
  def change
    add_column :recipients, :user_id, :integer
  end
end
