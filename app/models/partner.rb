class Partner < ActiveRecord::Base
  attr_accessible *attribute_names

  has_and_belongs_to_many :projects
  has_many :company_feedbacks
  has_many :partner_educations

  attr_accessible :projects, :project_ids
  attr_accessible :company_feedbacks, :company_feedback_ids
  attr_accessible :partner_educations, :partner_education_ids

  accepts_nested_attributes_for :partner_educations
  attr_accessible :partner_educations_attributes

  accepts_nested_attributes_for :company_feedbacks
  attr_accessible :company_feedbacks_attributes

  # paperclip

  has_attached_image :banner, styles: { page: "1366x500" }
  has_attached_image :avatar, styles: { partner_show: "158x158#", small_avatar: "62x62#" }



  # /paperclip


  translates :name, :status, :short_description_html, :full_description, :url_fragment
  accepts_nested_attributes_for :translations
  attr_accessible :translations, :translations_attributes

  class Translation
    attr_accessible *attribute_names
    belongs_to :item, class_name: Partner, foreign_key: :partner_id
    attr_accessible :item

    before_validation :set_url_fragment
    def set_url_fragment
      self.url_fragment = self.name.try(&:parameterize) if self.url_fragment.blank?
    end
  end


  # scopes

  scope :published, -> { where(published: true) }


  # url

  def to_param(locale = I18n.locale)
    self.translations_by_locale[locale].url_fragment
  end

  def url
    routes.partner_path(id: self)
  end

  def routes
    Rails.application.routes.url_helpers
  end
end
