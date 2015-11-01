class Event < ActiveRecord::Base
  attr_accessible *attribute_names

  # paperclip
  has_attached_file :banner, styles: { page: "1366x500", thumb: "205x75#" }

  attr_accessible :banner

  do_not_validate_attachment_file_type :banner

  translates :url_fragment, :name, :content, :short_description, :location_description, :time_string
  accepts_nested_attributes_for :translations
  attr_accessible :translations, :translations_attributes


  class Translation
    attr_accessible *attribute_names
    belongs_to :item, class_name: Event
    attr_accessible :item
  end
end
