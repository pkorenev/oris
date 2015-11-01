class CreateServices < ActiveRecord::Migration
  def up
    create_table :services do |t|
      t.boolean :published
      t.string :url_fragment
      t.string :name
      t.text :content


      t.timestamps null: false
    end

    Service.create_translation_table!(url_fragment: :string, name: :string, content: :text)
  end

  def down
    Service.drop_translation_table!

    drop_table :services
  end
end
