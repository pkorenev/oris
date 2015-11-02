require_relative 'require_libs'

def services_navigation_label
  navigation_label do
    I18n.t("admin.navigation_labels.services")
  end
end

def events_navigation_label
  navigation_label do
    I18n.t("admin.navigation_labels.events")
  end
end

def publications_navigation_label
  navigation_label do
    I18n.t("admin.navigation_labels.publications")
  end
end

def projects_navigation_label
  navigation_label do
    I18n.t("admin.navigation_labels.projects")
  end
end

def users_navigation_label
  navigation_label do
    I18n.t("admin.navigation_labels.users")
  end
end

def about_us_navigation_label
  navigation_label do
    I18n.t("admin.navigation_labels.about_us")
  end
end

def contact_navigation_label
  navigation_label do
    I18n.t("admin.navigation_labels.contact")
  end
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

  models = [Project, ProjectCategory, Event, EventAddress, Publication, PublicationCategory, Service, ServiceDepartment, ServicePractice, User, Partner, PartnerEducation, CompanyFeedback, Office ]

  models.each do |m|
    config.included_models += [m]
    if m.respond_to?(:translates?) && m.translates?
      config.included_models += [m.translation_class]
    end
  end


  # projects
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
      field :avatar do
        avatar_help
      end
      field :banner do
        banner_help
      end
      field :start_date
      field :end_date
      field :translations, :globalize_tabs
      field :partners
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

  config.model Service do
    visible false
  end

  config.model Service::Translation do
    visible false
  end

  def service_config
    services_navigation_label

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

  def service_translation_config
    visible false

    nested do
      field :locale, :hidden
      field :name
      field :url_fragment
      field :content, :ck_editor
    end
  end

  config.model ServicePractice do

    label do
      I18n.t("activerecord.models.service_practice.one")
    end

    label_plural do
      I18n.t("activerecord.models.service_practice.other")
    end

    service_config
  end

  config.model ServiceDepartment do

    label do
      I18n.t("activerecord.models.service_department.one")
    end

    label_plural do
      I18n.t("activerecord.models.service_department.other")
    end

    service_config
  end



  config.model ServiceDepartment::Translation do
    service_translation_config
  end

  config.model ServicePractice::Translation do
    service_translation_config
  end


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

end
