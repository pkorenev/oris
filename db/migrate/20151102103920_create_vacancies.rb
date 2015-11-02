class CreateVacancies < ActiveRecord::Migration
  def up
    create_table :vacancies do |t|
      t.boolean :published
      t.string :url_fragment
      t.string :name
      t.text :content


      t.timestamps null: false
    end

    Vacancy.create_translation_table!(url_fragment: :string, name: :string, content: :text)
  end

  def down
    Vacancy.drop_translation_table!

    drop_table :vacancies
  end
end
