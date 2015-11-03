class CreateTags < ActiveRecord::Migration
  def up
    create_table :tags do |t|
      t.string :name
      t.string :url_fragment

      t.timestamps null: false
    end

    HasTags::Tag.create_translation_table!(name: :string, url_fragment: :string)
  end

  def down
    HasTags::Tag.drop_translation_table!

    drop_table :tags
  end
end
