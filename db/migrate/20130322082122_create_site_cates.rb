class CreateSiteCates < ActiveRecord::Migration
  def change
    create_table :site_cates do |t|
      t.references :user
      t.string :name

      t.timestamps
    end
  end
end
