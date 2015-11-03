module HasTags
  class Tag < ActiveRecord::Base
    self.table_name = :tags
    attr_accessible *attribute_names

    has_many :taggings, class_name: "HasTags::Tagging"
    has_many :taggables, through: :taggings

    attr_accessible :taggings, :tagging_ids, :taggables, :taggable_ids


    translates :url_fragment, :name
    accepts_nested_attributes_for :translations
    attr_accessible :translations, :translations_attributes

    class Translation
      self.table_name = :tag_translations
      attr_accessible *attribute_names
      belongs_to :item, class_name: HasTags::Tag, foreign_key: :project_category_id
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
end