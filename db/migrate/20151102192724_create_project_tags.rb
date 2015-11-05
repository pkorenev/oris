class CreateProjectTags < ActiveRecord::Migration
  def up
    create_table :project_tags do |t|
      t.string :name
      t.string :url_fragment

      t.timestamps null: false
    end

    ProjectTag.create_translation_table!(name: :string, url_fragment: :string)
  end

  def down
    ProjectTag.drop_translation_table!

    drop_table :project_tags
  end
end
