class Pages::About < ActiveRecord::Base
  self.table_name = :about_pages

  attr_accessible *attribute_names
  translates :team_html, :feedbacks_intro_html, :why_trust_us_html, :why_oris_html, :clients_and_partners_html
  accepts_nested_attributes_for :translations
  attr_accessible :translations, :translations_attributes

  class Translation
    self.table_name = :about_page_translations
    attr_accessible *attribute_names
    belongs_to :item, class_name: HomePageBanner, foreign_key: :home_page_banner_id
    attr_accessible :item
  end
end