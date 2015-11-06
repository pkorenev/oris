class CreateServiceCategories < ActiveRecord::Migration
  def up
    create_table :service_categories do |t|
      t.string :name
      t.string :url_fragment

      t.timestamps null: false
    end

    ServiceCategory.create_translation_table!(name: :string, url_fragment: :string)
  end

  def down
    ServiceCategory.drop_translation_table!

    drop_table :service_categories
  end
end
