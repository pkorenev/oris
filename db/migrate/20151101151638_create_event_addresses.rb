class CreateEventAddresses < ActiveRecord::Migration
  def up
    create_table :event_addresses do |t|
      t.text :address_text
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end

    EventAddress.create_translation_table!(address_text: :text)
  end

  def down
    EventAddress.drop_translation_table!

    drop_table :event_addresses
  end
end
