class Service < ActiveRecord::Base
  attr_accessible *attribute_names

  belongs_to :service_category
  has_and_belongs_to_many :projects
  #has_many :projects

  attr_accessible :projects, :project_ids
  attr_accessible :service_category

  translates :url_fragment, :name, :content
  accepts_nested_attributes_for :translations
  attr_accessible :translations, :translations_attributes



  scope :order_by_desc, -> { order("created_at desc") }
  scope :published, -> { where(published: true) }


  class Translation
    attr_accessible *attribute_names
    belongs_to :item, class_name: Service
    attr_accessible :item

    before_validation :set_url_fragment
    def set_url_fragment
      self.url_fragment = self.name.parameterize if self.url_fragment.blank?
    end

    searchable do
      string :locale
      text :name
      text :content
    end
  end

  def list_item_name(index, locale = I18n.locale)
    name = translations_by_locale[locale].try(&:name)
    "#{index + 1}. #{name}"
  end

  def to_param(locale = I18n.locale)
    self.translations_by_locale[locale].url_fragment
  end

  def url(locale = I18n.locale)
    routes.service_path(service_category: self.service_category, id: self, locale: locale)
  end

  def routes
    Rails.application.routes.url_helpers
  end
end
