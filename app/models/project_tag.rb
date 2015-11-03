class ProjectTag < ActiveRecord::Base
  attr_accessible *attribute_names

  has_and_belongs_to_many :projects
  attr_accessible :projects, :project_ids

  translates :url_fragment, :name
  accepts_nested_attributes_for :translations
  attr_accessible :translations, :translations_attributes

  class Translation
    attr_accessible *attribute_names
    belongs_to :item, class_name: ProjectTag, foreign_key: :project_tag_id
    attr_accessible :item

    before_validation :set_url_fragment
    def set_url_fragment
      self.url_fragment = self.name.parameterize if self.url_fragment.blank?
    end
  end



  #

  def to_param(locale = I18n.locale)
    self.translations_by_locale[locale].url_fragment
  end

  def url
    routes.project_tag_path(id: self)
  end

  def routes
    Rails.application.routes.url_helpers
  end
end
