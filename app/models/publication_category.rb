class PublicationCategory < ActiveRecord::Base
  attr_accessible *attribute_names

  has_many :publications
  attr_accessible :publications, :publication_ids

  translates :url_fragment, :name
  accepts_nested_attributes_for :translations
  attr_accessible :translations, :translations_attributes

  class Translation
    attr_accessible *attribute_names
    belongs_to :item, class_name: PublicationCategory, foreign_key: :publication_category_id
    attr_accessible :item

    before_validation :set_url_fragment
    def set_url_fragment
      self.url_fragment = self.name.parameterize if self.url_fragment.blank?
    end
  end

  def to_param(locale = I18n.locale)
    self.translations_by_locale[locale].url_fragment
  end

  def url

  end
end
