class Vacancy < ActiveRecord::Base
  attr_accessible *attribute_names

  # associations
  has_many :vacancy_requests

  translates :url_fragment, :name, :content
  accepts_nested_attributes_for :translations
  attr_accessible :translations, :translations_attributes

  scope :published, -> { where(published: true) }


  class Translation
    attr_accessible *attribute_names
    belongs_to :item, class_name: Service
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
    routes.vacancy_path(vacancy_id: self, locale: locale)
  end

  def routes
    Rails.application.routes.url_helpers
  end
end
