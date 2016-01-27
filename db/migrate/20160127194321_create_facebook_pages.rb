class CreateFacebookPages < ActiveRecord::Migration
  def change
    create_table :facebook_pages do |t|
      t.string :name, limit: 255
      t.string :page_id, limit: 255
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :facebook_pages, :user_id
  end
end
