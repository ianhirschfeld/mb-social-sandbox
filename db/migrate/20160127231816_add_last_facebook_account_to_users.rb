class AddLastFacebookAccountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_facebook_account, :string, limit: 255, default: '0'
  end
end
