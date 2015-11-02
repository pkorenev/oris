class CreateOffices < ActiveRecord::Migration
  def up
    create_table :offices do |t|
      t.boolean :published
      t.string :city
      t.string :short_description
      t.string :address
      t.float :longitude
      t.float :latitude
      t.text :phones
      t.text :emails
      t.has_attached_file :avatar
      t.string :social_facebook
      t.string :social_twitter
      t.string :social_linked_in

      t.timestamps null: false
    end

    Office.create_translation_table!(city: :string, short_description: :text, address: :text)
  end

  def down
    Office.drop_translation_table!
    drop_table :offices
  end
end
