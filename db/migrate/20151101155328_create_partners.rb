class CreatePartners < ActiveRecord::Migration
  def up
    create_table :partners do |t|
      t.boolean :published
      t.string :name
      t.string :status
      t.text :short_description_html
      t.has_attached_file :avatar
      t.has_attached_file :banner
      t.text :full_description
      t.string :url_fragment

      t.timestamps null: false
    end

    Partner.create_translation_table!(name: :string, status: :string, short_description_html: :text, full_description: :text, url_fragment: :string)
  end

  def down
    Partner.drop_translation_table!
    drop_table :partners
  end
end
