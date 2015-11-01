class CreateProjects < ActiveRecord::Migration
  def up
    create_table :projects do |t|
      t.boolean :published
      t.string :url_fragment
      t.string :name
      t.text :content
      t.text :short_description
      t.has_attached_file :avatar
      t.has_attached_file :banner

      t.date :start_date
      t.date :end_date
      t.timestamps null: false
    end

    Project.create_translation_table!(url_fragment: :string, name: :string, content: :text, short_description: :text)
  end

  def down
    Project.drop_translation_table!

    drop_table :projects
  end
end
