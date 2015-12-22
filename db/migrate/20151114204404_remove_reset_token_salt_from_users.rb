class RemoveResetTokenSaltFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :reset_token_salt, :string
  end
end
