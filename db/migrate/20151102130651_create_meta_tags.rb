class CreateMetaTags < ActiveRecord::Migration
  def up
    create_table :meta_tags do |t|
      t.string :title
      t.text :description
      t.text :keywords

      t.string :page_type
      t.integer :page_id

      t.timestamps null: false
    end

    Cms::MetaTags.create_translation_table!
  end

  def down
    drop_table :meta_tags

    Cms::MetaTags.drop_translation_table!
  end
end
