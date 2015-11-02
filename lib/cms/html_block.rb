module Cms
  class HtmlBlock < ActiveRecord::Base
    self.table_name = :html_blocks

    attr_accessible *attribute_names

    belongs_to :attachable, polymorphic: true

    if respond_to?(:translates) && translates?
      translates :content
      accepts_nested_attributes_for :translations
      attr_accessible :translations, :translations_attributes


      class Translation
        attr_accessible *attribute_names
      end

    end

    scope :by_key, ->(key) { where(key: key) }
    scope :by_field, ->(field) { where(attachable_field_name: field) }
    # def self.by_key(key)
    #   where(key: key).first
    # end


  end
end