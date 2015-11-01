class CreatePublications < ActiveRecord::Migration
  def up
    create_table :publications do |t|
      t.boolean :published
      t.string :url_fragment
      t.string :name
      t.text :content
      t.has_attached_file :avatar
      t.has_attached_file :banner



      t.timestamps null: false
    end

    Publication.create_translation_table!(url_fragment: :string, name: :string, content: :text)
  end

  def down
    Publication.drop_translation_table!

    drop_table :publications
  end
end
