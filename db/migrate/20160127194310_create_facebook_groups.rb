class CreateFacebookGroups < ActiveRecord::Migration
  def change
    create_table :facebook_groups do |t|
      t.string :name, limit: 255
      t.string :group_id, limit: 255
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :facebook_groups, :user_id
  end
end
