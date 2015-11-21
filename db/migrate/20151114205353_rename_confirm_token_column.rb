class RenameConfirmTokenColumn < ActiveRecord::Migration
  def change
    rename_column :users, :confirm_token, :confirm_digest
  end
end
