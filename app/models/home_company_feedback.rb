class HomeCompanyFeedback < ActiveRecord::Base
  attr_accessible *attribute_names
  translates :company_name, :comment, :company_url
  accepts_nested_attributes_for :translations
  attr_accessible :translations, :translations_attributes

  class Translation
    attr_accessible *attribute_names
    belongs_to :item, class_name: HomePageBanner, foreign_key: :home_page_banner_id
    attr_accessible :item
  end
end
