class CreateProjectCategories < ActiveRecord::Migration
  def up
    create_table :project_categories do |t|
      t.string :name
      t.string :url_fragment

      t.timestamps null: false
    end

    ProjectCategory.create_translation_table!(name: :string, url_fragment: :string)
  end

  def down
    ProjectCategory.drop_translation_table!

    drop_table :project_categories
  end
end
