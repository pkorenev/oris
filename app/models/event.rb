class Event < ActiveRecord::Base
  attr_accessible *attribute_names

  belongs_to :event_address

  # paperclip
  has_attached_image :banner, styles: { page: "1366x500", thumb: "205x75#" }




  scope :published, -> { where(published: true) }
  scope :order_by_event_date_asc, -> { order("event_datetime asc") }
  scope :order_by_event_date_desc, -> { order("event_datetime desc") }
  scope :featured, -> { where("event_datetime > ?", DateTime.now) }
  scope :completed, -> { where("event_datetime < ?", DateTime.now) }


  translates :url_fragment, :name, :content, :short_description, :location_description, :time_string, :city
  accepts_nested_attributes_for :translations
  attr_accessible :translations, :translations_attributes

  class Translation
    attr_accessible *attribute_names
    belongs_to :item, class_name: Event, foreign_key: :event_id
    attr_accessible :item

    before_validation :set_url_fragment
    def set_url_fragment
      self.url_fragment = self.name.try(&:parameterize) if self.url_fragment.blank?
    end

    searchable do
      string :locale
      text :name
      text :content
    end
  end


  # additional methods
  def formatted_numeric_date(date = created_at)
    "#{date.day}/#{date.month}/#{date.year}"
  end

  def formatted_word_date(date = event_datetime)
    month_name = "декабря"
    "#{date.day} #{month_name} #{date.year}"
  end

  # url

  def to_param(locale = I18n.locale)
    self.translations_by_locale[locale].url_fragment
  end

  def url
    routes.event_path(id: self)
  end

  def routes
    Rails.application.routes.url_helpers
  end

  # / url

  def short_date
    date = self.event_datetime
    "#{date.day}/#{date.month}"
  end

  def event_time
    datetime = self.event_datetime
    minutes = datetime.min
    if minutes < 10
      minutes = "0#{minutes}"
    end
    "#{datetime.hour}:#{minutes}"
  end
end
