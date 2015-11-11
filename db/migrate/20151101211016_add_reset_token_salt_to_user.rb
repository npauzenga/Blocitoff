class AddResetTokenSaltToUser < ActiveRecord::Migration
  def change
    add_column :users, :reset_token_salt, :string
  end
end
