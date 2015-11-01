class AddCityToEventTranslations < ActiveRecord::Migration
  def change
    add_column :event_translations, :city, :string
  end
end
