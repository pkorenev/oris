class CreateHomePageBanners < ActiveRecord::Migration
  def up
    create_table :home_page_banners do |t|
      t.boolean :published
      t.integer :position
      t.has_attached_file :image
      t.text :short_description

      t.timestamps null: false
    end

    HomePageBanner.create_translation_table!(short_description: :text)
  end

  def down
    HomePageBanner.drop_translation_table!

    drop_table :home_page_banners
  end
end
