class ProjectCategory < ActiveRecord::Base
  attr_accessible *attribute_names

  has_many :projects
  attr_accessible :projects, :project_ids

  translates :url_fragment, :name
  accepts_nested_attributes_for :translations
  attr_accessible :translations, :translations_attributes

  class Translation
    attr_accessible *attribute_names
    belongs_to :item, class_name: ProjectCategory, foreign_key: :project_category_id
    attr_accessible :item

    before_validation :set_url_fragment
    def set_url_fragment
      self.url_fragment = self.name.parameterize if self.url_fragment.blank?
    end
  end

  # additional methods

  def to_param(locale = I18n.locale)
    self.translations_by_locale[locale].url_fragment
  end

  def url
    routes.projects_category_path(project_category: self)
  end

  def routes
    Rails.application.routes.url_helpers
  end
end
