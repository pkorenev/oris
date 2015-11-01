class CreatePublicationCategories < ActiveRecord::Migration
  def up
    create_table :publication_categories do |t|
      t.string :name
      t.string :url_fragment

      t.timestamps null: false
    end

    PublicationCategory.create_translation_table!(name: :string, url_fragment: :string)
  end

  def down
    PublicationCategory.drop_translation_table!

    drop_table :publication_categories
  end
end
