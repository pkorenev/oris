class Office < ActiveRecord::Base
  attr_accessible *attribute_names

  has_attached_image :avatar, styles: { contact_item: "582x450#", thumb: "100x150#" }

  translates :city, :short_description, :address
  accepts_nested_attributes_for :translations
  attr_accessible :translations, :translations_attributes

  class Translation
    attr_accessible *attribute_names
    belongs_to :item, class_name: Office, foreign_key: :office_id
    attr_accessible :item
  end

  scope :published, -> { where(published: true) }

  def phones
    self['phones'].try do |phones|
      phones.split(/\r\n/)
    end || []
  end

  def emails
    self['emails'].try do |emails|
      emails.split(/\r\n/)
    end || []
  end
end
