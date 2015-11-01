class CreateEvents < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.boolean :published
      t.string :url_fragment
      t.string :name
      t.text :content
      t.text :short_description
      t.has_attached_file :banner

      t.datetime :event_datetime
      t.string :city
      t.string :time_string
      t.string :location_description

      t.timestamps null: false
    end

    Event.create_translation_table!(url_fragment: :string, name: :string, content: :text, short_description: :text, location_description: :string, time_string: :string)
  end

  def down
    Event.drop_translation_table!

    drop_table :events
  end
end
