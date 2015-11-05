class CreateHomePages < ActiveRecord::Migration
  def up
    create_table :home_pages do |t|
      t.text :about_html
      t.integer :years_of_experience
      t.integer :projects_count
      t.integer :happy_clients_count
    end

    Pages::Home.create_translation_table!(about_html: :text)
  end

  def down
    Pages::Home.drop_translation_table!

    drop_table :home_pages
  end
end
