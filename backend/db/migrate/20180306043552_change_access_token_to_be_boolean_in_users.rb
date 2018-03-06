class ChangeAccessTokenToBeBooleanInUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :auth_token, :boolean
  end
end
