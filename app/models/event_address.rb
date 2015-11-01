class EventAddress < ActiveRecord::Base
  attr_accessible *attribute_names

  has_many :events

  translates :address_text
  accepts_nested_attributes_for :translations
  attr_accessible :translations, :translations_attributes

  class Translation
    attr_accessible *attribute_names
    belongs_to :item, class_name: EventAddress, foreign_key: :event_address_id
    attr_accessible :item
  end
end
