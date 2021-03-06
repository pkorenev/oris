Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  #root to: 'pages#stub'




  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    post "subscribe", to: "mailchimp#subscribe"
    controller "forms" do
      post "contact_feedback", action: "contact_message_request", as: :contact_feedback
      #post "subscribe", action: "subscription_request", as: :subscribe
      post "order-service", action: "order_service_request", as: :order_service
      post "vacancies/:vacancy_id", action: "vacancy_request", as: :vacancy_request
    end


    root to: "pages#index"
    get "career/:vacancy_id", to: "vacancies#show", as: :vacancy, defaults: { menu_item: :career }
    get "career", to: "vacancies#index", as: :career, defaults: { menu_item: :career, menu_item_root: true }
    get "about", to: "pages#about", defaults: { menu_item: :about, menu_item_root: true }
    get "contact", to: "pages#contact", defaults: { menu_item: :contact, menu_item_root: true }
    get "search", to: "pages#search", defaults: { menu_item: :contact, menu_item_root: true }

    scope :events, defaults: { menu_item: :events } do
      root to: "events#index", as: :events, defaults: { menu_item_root: true }
      get ":id", to: "events#show", as: :event
    end

    scope "services", defaults: { menu_item: :services } do
      root to: "services#index", as: :services
      #get "practices", to: "services#index", defaults: { resource_class: "ServicePractice", menu_item_root: true }, as: :services_practices
      #get "departments", to: "services#index", defaults: { resource_class: "ServiceDepartment" }, as: :services_departments
      scope ":service_category" do
        root to: "services#index", as: "services_category"
        get ":id", to: "services#show", as: :service
      end
    end

    scope "projects", defaults: { menu_item: :projects } do
      root to: "projects#index", as: :projects, defaults: { menu_item_root: true }
      scope ":project_category" do
        root to: "projects#index", as: "projects_category"
        get ":id", to: "projects#show", as: :project
      end

    end

    scope "publications", defaults: { menu_item: :publications } do
      root to: "publications#index", as: :publications, defaults: { menu_item_root: true }
      scope ":publication_category" do
        root to: "publications#index", as: "publications_category"
        get ":id", to: "publications#show", as: :publication
      end

    end

    scope "partners", defaults: { menu_item: :about } do
      get ":id", to: "partners#show", as: :partner
    end
  end

  match "*url", to: "application#not_found", via: [:get, :post, :put, :update, :delete]
end
