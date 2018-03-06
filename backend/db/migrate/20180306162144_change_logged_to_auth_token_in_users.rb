class ChangeLoggedToAuthTokenInUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :logged, :auth_token
    change_column :users, :auth_token, :string
  end
end
