class CreateClients < ActiveRecord::Migration
  def up
    create_table :clients do |t|
      t.boolean :published
      t.string :name
      t.string :company_url
      t.has_attached_file :avatar
      t.text :short_description

      t.timestamps null: false
    end

    Client.create_translation_table!(name: :string, company_url: :string, short_description: :text)
  end

  def down
    Client.drop_translation_table!

    drop_table :clients


  end
end
