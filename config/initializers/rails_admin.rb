require_relative 'require_libs'

def pages_models
  Dir[Rails.root.join("app/models/pages/*")].map{|p| filename = File.basename(p, ".rb"); "Pages::" + filename.camelize }
end

def include_pages_models(config)
  include_models(config, *pages_models)
end

def include_models(config, *models)
  models.each do |model|
    config.included_models += [model]

    if !model.instance_of?(Class)
      Dir[Rails.root.join("app/models/#{model.underscore}")].each do |file_name|
        require file_name
      end

      model = model.constantize rescue nil
    end

    if model.respond_to?(:translates?) && model.translates?
      config.included_models += [model.translation_class]
    end
  end
end

def keyed_navigation_label(key)
  navigation_label do
    I18n.t("admin.navigation_labels.#{key}", raise: true) rescue key.humanize
  end
end

def services_navigation_label
  keyed_navigation_label("services")
end

def events_navigation_label
  keyed_navigation_label("events")
end

def publications_navigation_label
  keyed_navigation_label("publications")
end

def projects_navigation_label
  keyed_navigation_label("projects")
end

def users_navigation_label
  keyed_navigation_label("users")
end

def about_us_navigation_label
  keyed_navigation_label("about_us")
end

def contact_navigation_label
  keyed_navigation_label("contact")
end

def paperclip_help(field_name)
  help do
    "#{generic_field_help} #{ styles = @bindings[:object].send(field_name).styles.map{|k, v|  "#{v.geometry}" }; styles_string = styles.join("; "); "#{styles.count > 1 ? 'Размеры: ' : 'Размер: ' }#{styles_string} "}"
  end
end

def avatar_help
  paperclip_help(:avatar)
end

def banner_help
  paperclip_help(:banner)
end


RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end



  #include_models config, HasTags::Tag, HasTags::Tagging


  models = [Pages, Project, ProjectTag, ProjectCategory, Client, Event, EventAddress, Publication, PublicationCategory, Service, User, Vacancy, Partner, PartnerEducation, CompanyFeedback, Office ]
  include_pages_models(config)

  include_models(config, ServiceCategory)

  models.each do |m|
    config.included_models += [m]
    if m.respond_to?(:translates?) && m.translates?
      config.included_models += [m.translation_class]
    end
  end


  # projects
  config.model ProjectTag do
    projects_navigation_label

    list do
      field :name
      field :url_fragment
      field :projects
    end

    edit do
      field :translations, :globalize_tabs
      field :projects
    end

    nested do
      field :translations, :globalize_tabs
    end
  end

  config.model ProjectTag::Translation do
    visible false

    nested do
      field :locale, :hidden
      field :name
      field :url_fragment
    end
  end

  config.model ProjectCategory do
    projects_navigation_label

    list do
      field :name
      field :url_fragment
      field :projects
    end

    edit do
      field :translations, :globalize_tabs
      field :projects
    end
  end

  config.model ProjectCategory::Translation do
    visible false

    nested do
      field :locale, :hidden
      field :name
      field :url_fragment
    end
  end

  config.model Project do
    projects_navigation_label

    list do
      field :published
      field :project_category
      field :name
      field :date_range
      field :avatar
      field :partners

    end

    edit do
      field :published
      field :project_category
      field :project_tags
      field :services
      field :partners
      field :avatar do
        avatar_help
      end
      field :banner do
        banner_help
      end
      field :start_date
      field :end_date
      field :translations, :globalize_tabs

    end
  end

  config.model Project::Translation do
    visible false

    nested do
      field :locale, :hidden
      field :name
      field :url_fragment
      field :short_description
      field :content, :ck_editor
    end
  end

  # publications

  config.model PublicationCategory do
    publications_navigation_label

    list do
      field :name
      field :url_fragment
      field :publications
    end

    edit do
      field :translations, :globalize_tabs
      field :publications
    end
  end

  config.model PublicationCategory::Translation do
    visible false

    nested do
      field :locale, :hidden
      field :name
      field :url_fragment
    end
  end

  config.model Publication do
    publications_navigation_label

    list do
      field :publication_category
      field :published
      field :name
      field :url_fragment
      field :avatar
      field :banner
    end

    edit do
      field :publication_category
      field :published
      field :avatar do
        avatar_help
      end
      field :banner do
        banner_help
      end
      field :translations, :globalize_tabs
    end
  end

  config.model Publication::Translation do
    visible false

    nested do
      field :locale, :hidden
      field :name
      field :url_fragment
      field :content, :ck_editor
    end
  end

  # events

  config.model EventAddress do
    events_navigation_label

    list do
      field :address_text
    end

    edit do
      field :translations, :globalize_tabs
    end
  end

  config.model EventAddress::Translation do
    visible false

    nested do
      field :locale, :hidden
      field :address_text
    end
  end

  config.model Event do
    events_navigation_label

    list do
      field :published
      field :city
      #field :completed_at
      field :name
      field :url_fragment
      field :short_description
      field :banner
    end
    edit do
      field :published
      #field :completed_at
      field :event_address
      field :banner do
        banner_help
      end
      field :event_datetime
      field :translations, :globalize_tabs
    end
  end

  config.model Event::Translation do
    visible false

    nested do
      field :locale, :hidden
      field :city
      field :name
      field :url_fragment
      field :short_description
      field :content, :ck_editor
      field :location_description
      field :time_string
    end
  end

  # services

  config.model ServiceCategory do
    services_navigation_label

    list do
      field :name
      field :url_fragment
      field :services
    end

    edit do
      field :translations, :globalize_tabs
      field :services
    end
  end

  config.model ServiceCategory::Translation do
    visible false

    nested do
      field :locale, :hidden
      field :name
      field :url_fragment
    end
  end

  config.model Service do
    services_navigation_label
    list do
      field :published
      field :service_category
      field :name
      field :url_fragment
    end

    edit do
      field :published
      field :service_category
      field :translations, :globalize_tabs
    end
  end

  config.model Service::Translation do
    service_translation_config
  end

  def service_config
    list_item_config(:services_navigation_label)
  end

  def service_translation_config
    list_item_translation_config
  end

  def list_item_config(label_method = nil)
    if label_method
      send(label_method)
    end

    list do
      field :published
      field :name
      field :url_fragment
    end

    edit do
      field :published
      field :translations, :globalize_tabs
    end
  end

  def list_item_translation_config
    visible false

    nested do
      field :locale, :hidden
      field :name
      field :url_fragment
      field :content, :ck_editor
    end
  end

  # config.model ServicePractice do
  #   visible false
  #   label do
  #     I18n.t("activerecord.models.service_practice.one")
  #   end
  #
  #   label_plural do
  #     I18n.t("activerecord.models.service_practice.other")
  #   end
  #
  #   service_config
  # end
  #
  # config.model ServiceDepartment do
  #   visible false
  #   label do
  #     I18n.t("activerecord.models.service_department.one")
  #   end
  #
  #   label_plural do
  #     I18n.t("activerecord.models.service_department.other")
  #   end
  #
  #   service_config
  # end



  # config.model ServiceDepartment::Translation do
  #   service_translation_config
  # end
  #
  # config.model ServicePractice::Translation do
  #   service_translation_config
  # end


  config.model User do
    users_navigation_label

    list do
      field :email
    end

    edit do
      field :email
      field :password
      field :password_confirmation
    end
  end


  # about

  config.model Vacancy do
    list_item_config(:about_us_navigation_label)
  end

  config.model Vacancy::Translation do
    list_item_translation_config
  end

  config.model Client do
    projects_navigation_label

    list do
      field :published
      field :avatar
      field :short_description
      field :name
      field :projects
    end

    edit do
      field :published
      field :translations, :globalize_tabs

      field :avatar do
        avatar_help
      end
      field :projects
    end
  end

  config.model Client::Translation do
    visible false

    nested do
      field :locale, :hidden
      field :name
      field :company_url
      field :short_description
    end
  end

  config.model Partner do
    about_us_navigation_label

    list do
      field :published
      field :avatar
      field :banner
      field :status
      field :name
      field :projects
    end

    edit do
      field :translations, :globalize_tabs
      field :published
      field :avatar do
        avatar_help
      end
      field :banner do
        banner_help
      end
      field :partner_educations
      field :company_feedbacks
      field :projects

    end
  end

  config.model Partner::Translation do
    visible false

    nested do
      field :locale, :hidden
      field :name
      field :url_fragment
      field :status
      field :short_description_html, :ck_editor
      field :full_description, :ck_editor
    end
  end

  config.model PartnerEducation do
    visible false

    nested do
      field :translations, :globalize_tabs
    end
  end

  config.model PartnerEducation::Translation do
    visible false

    nested do
      field :locale, :hidden
      field :school_name
      field :degree do
        help do
          generic_field_help + "Например: магистр, бакалавр"
        end
      end
    end
  end

  config.model CompanyFeedback do
    visible false

    nested do
      field :translations, :globalize_tabs
    end
  end

  config.model CompanyFeedback::Translation do
    visible false

    nested do
      field :locale, :hidden
      field :name
      field :comment
      field :company_url
    end
  end

  config.model Office do
    contact_navigation_label

    edit do
      field :published
      field :translations, :globalize_tabs
      field :longitude
      field :latitude
      field :phones
      field :emails
      field :avatar
      field :social_facebook
      field :social_twitter
      field :social_linked_in
    end
  end

  config.model Office::Translation do
    visible false

    nested do
      field :locale, :hidden
      field :city
      field :short_description
      field :address
    end
  end

  config.model Cms::Page do
    visible false
  end

  config.model Cms::Page::Translation do
    visible false
  end


  config.model Pages::Home do
    visible false
    # edit do
    #   #field :banners
    #   field :translations, :globalize_tabs
    #   field :years_of_experience
    #   field :projects_count
    #   field :happy_clients_count
    #   field :seo_tags
    #   field :sitemap_record
    # end
  end

  config.model Pages::Home::Translation do
    visible false

    nested do
      field :locale, :hidden
      field :about_html
    end
  end

  config.model Pages::About do
    visible false
  end

  config.model Pages::About::Translation do
    visible false
  end

  config.model Pages::Career do
    visible false
  end

  config.model Pages::Career::Translation do
    visible false
  end



end


# ServicePractice [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
# ServiceDepartment [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41]


# ServiceDepartment [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41]
# ServicePractice [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]