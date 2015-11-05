class CreateAboutFeatures < ActiveRecord::Migration
  def up
    create_table :about_features do |t|
      t.string :name
      t.has_attached_file :image
      

      t.timestamps null: false
    end

    AboutFeature.create_translation_table!(name :string)
  end

  def down
    AboutFeature.drop_translation_table!
  end
end
