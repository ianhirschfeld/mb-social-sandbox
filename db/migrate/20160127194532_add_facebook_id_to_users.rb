class AddFacebookIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facebook_id, :string, limit: 255
    add_column :users, :facebook_access_token, :string, limit: 255

    add_index :users, :facebook_id
  end
end
