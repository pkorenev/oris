class Client < ActiveRecord::Base
  attr_accessible *attribute_names

  has_and_belongs_to_many :projects
  attr_accessible :projects, :project_ids


  has_attached_image :avatar, styles: { small_avatar: "62x62#" }

  translates :company_url, :name, :short_description
  accepts_nested_attributes_for :translations
  attr_accessible :translations, :translations_attributes

  class Translation
    attr_accessible *attribute_names
    belongs_to :item, class_name: Client, foreign_key: :client_id
    attr_accessible :item
  end

  # scopes
  scope :published, -> { where(published: true) }

  # additional methods


end
