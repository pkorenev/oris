class Publication < ActiveRecord::Base
  attr_accessible *attribute_names

  belongs_to :publication_category
  attr_accessible :publication_category

  # paperclip
  has_attached_image :avatar, styles: { publications_index: "220x320#", thumb: "100x150#" }
  has_attached_image :banner, styles: { page: "1366x500", thumb: "205x75#" }

  amoeba do
    include_association :translations
  end


  translates :url_fragment, :name, :content
  accepts_nested_attributes_for :translations
  attr_accessible :translations, :translations_attributes


  class Translation
    attr_accessible *attribute_names
    belongs_to :item, class_name: Publication, foreign_key: :publication_id
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


  # scopes

  scope :published, -> { where(published: true) }
  scope :order_by_created_at_desc, -> { order("created_at desc") }

  # validations

  validates :publication_category, :avatar, :banner, :name, :url_fragment, :content, presence: { message: "Заполните, прежде чем опубликовать" }, if: -> { self.published? }


  # additional methods

  def formatted_numeric_date
    date = created_at
    "#{date.day}/#{date.month}/#{date.year}"
  end

  def formatted_word_date
    date = created_at
    month_name = "декабря"
    "#{date.day} #{month_name} #{date.year}"
  end

  def to_param(locale = I18n.locale)
    self.translations_by_locale[locale].url_fragment
  end

  def url
    routes.publication_path(publication_category: self.publication_category, id: self)
  end

  def routes
    Rails.application.routes.url_helpers
  end
end
