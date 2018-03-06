class ChangeAccessTokenToLoggedInUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :auth_token, :logged
  end
end
