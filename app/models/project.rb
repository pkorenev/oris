class Project < ActiveRecord::Base
  attr_accessible *attribute_names

  # paperclip
  has_attached_file :avatar, styles: { projects_index: "469x166" }
  has_attached_file :banner, styles: { page: "1366x500" }

  attr_accessible :banner
  attr_accessible :avatar

  do_not_validate_attachment_file_type :banner
  do_not_validate_attachment_file_type :avatar


  translates :url_fragment, :name, :content, :short_description
  accepts_nested_attributes_for :translations
  attr_accessible :translations, :translations_attributes


  class Translation
    attr_accessible *attribute_names
    belongs_to :item, class_name: Project
    attr_accessible :item
  end

  def date_range
    "#{start_date} - #{end_date}"
  end
end
