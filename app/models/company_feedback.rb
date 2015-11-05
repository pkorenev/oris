class CompanyFeedback < ActiveRecord::Base
  attr_accessible *attribute_names

  translates :name, :comment, :company_url
  accepts_nested_attributes_for :translations
  attr_accessible :translations, :translations_attributes

  class Translation
    attr_accessible *attribute_names
    belongs_to :item, class_name: CompanyFeedback, foreign_key: :company_feedback_id
    attr_accessible :item
  end
end
