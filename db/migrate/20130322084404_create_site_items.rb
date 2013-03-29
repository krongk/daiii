class CreateSiteItems < ActiveRecord::Migration
  def change
    create_table :site_items do |t|
      t.references :user
      t.references :site_cate
      t.string :site_url
      t.string :site_title
      t.string :site_username
      t.string :site_icon
      t.string :site_password
      t.string :site_password_tips
      t.text :note
      t.integer :visit_count, :default => 0
      t.integer :rate_count, :default => 0

      t.timestamps
    end
    add_index :site_items, :site_cate_id
  end
end
