module HasTags
  class Tagging < ActiveRecord::Base
    self.table_name = :taggings
    attr_accessible *attribute_names

    belongs_to :tag, class_name: HasTags::Tag
    belongs_to :taggable, polymorphic: true

    attr_accessible :tag
    attr_accessible :taggable
  end
end