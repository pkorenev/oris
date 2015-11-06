class Pages::Home < ActiveRecord::Base
  self.table_name = :home_pages
  attr_accessible *attribute_names

  has_seo_tags
  has_sitemap_record

  translates :about_html
  accepts_nested_attributes_for :translations
  attr_accessible :translations, :translations_attributes

  class Translation
    attr_accessible *attribute_names
    belongs_to :item, class_name: HomePageBanner, foreign_key: :home_page_banner_id
    attr_accessible :item
  end

  def self.default_head_title
    page_key = self.name.split("::").last.underscore
    I18n.t("pages.home.head_title", raise: true) rescue page_key.humanize.parameterize
  end

end