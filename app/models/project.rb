class Project < ActiveRecord::Base
  attr_accessible *attribute_names

  belongs_to :project_category
  has_and_belongs_to_many :partners
  has_and_belongs_to_many :services
  has_and_belongs_to_many :project_tags
  #has_tags
  has_and_belongs_to_many :clients
  #belongs_to :service_practice
  #belongs_to :service_department

  attr_accessible :project_category
  attr_accessible :partners, :partner_ids
  #attr_accessible :services, :service_ids

  attr_accessible :project_tags, :project_tag_ids
  attr_accessible :clients, :client_ids
  # paperclip

  has_attached_image :avatar, styles: { projects_index: "469x166" }
  has_attached_image :banner, styles: { page: "1366x500" }

  # / paperclip


  translates :url_fragment, :name, :content, :short_description
  accepts_nested_attributes_for :translations
  attr_accessible :translations, :translations_attributes


  class Translation
    attr_accessible *attribute_names
    belongs_to :item, class_name: Project, foreign_key: :project_id
    attr_accessible :item

    before_validation :set_url_fragment
    def set_url_fragment
      self.url_fragment = self.name.parameterize if self.url_fragment.blank?
    end
  end

  # scopes
  scope :published, -> { where(published: true) }

  def date_range
    "20 октября 2014 – 19 января 2015"
    "#{start_date} - #{end_date}"
  end

  # url

  def to_param(locale = I18n.locale)
    self.translations_by_locale[locale].url_fragment
  end

  def url
    routes.project_path(project_category: self.project_category, id: self)
  end

  def routes
    Rails.application.routes.url_helpers
  end
end
