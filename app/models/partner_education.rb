class PartnerEducation < ActiveRecord::Base
  attr_accessible *attribute_names

  belongs_to :partner

  translates :school_name, :degree
  accepts_nested_attributes_for :translations
  attr_accessible :translations, :translations_attributes

  class Translation
    attr_accessible *attribute_names
    belongs_to :item, class_name: PartnerEducation, foreign_key: :partner_education_id
    attr_accessible :item
  end
end
