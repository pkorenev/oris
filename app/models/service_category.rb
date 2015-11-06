class ServiceCategory < ActiveRecord::Base
  attr_accessible *attribute_names

  has_many :services
  attr_accessible :services, :service_ids

  translates :url_fragment, :name
  accepts_nested_attributes_for :translations
  attr_accessible :translations, :translations_attributes

  class Translation
    attr_accessible *attribute_names
    belongs_to :item, class_name: ServiceCategory, foreign_key: :service_category_id
    attr_accessible :item

    before_validation :set_url_fragment
    def set_url_fragment
      self.url_fragment = self.name.parameterize if self.url_fragment.blank?
    end
  end

  def to_param(locale = I18n.locale)
    self.translations_by_locale[locale].url_fragment
  end

  def url(locale = I18n.locale)
    routes.services_category_path(service_category: self.to_param(locale), locale: locale)
  end

  def routes
    Rails.application.routes.url_helpers
  end
end
