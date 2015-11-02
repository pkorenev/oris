Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  #root to: 'pages#stub'
  post "subscribe", to: "mailchimp#subscribe"

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root to: "pages#index"
    get "career", to: "pages#career", as: :career
    get "about", to: "pages#about"
    get "contact", to: "pages#contact"
    resources :events, only: [:index, :show]


    scope "services" do
      root to: "services#index", as: :services
      get "practices", to: "services#index", defaults: { resource_class: "ServicePractice" }, as: :services_practices
      get "departments", to: "services#index", defaults: { resource_class: "ServiceDepartment" }, as: :services_departments
      get ":id", to: "services#show", as: :service

    end

    scope "projects" do
      root to: "projects#index", as: :projects
      scope ":project_category" do
        root to: "projects#index", as: "projects_category"
        get ":id", to: "projects#show", as: :project
      end

    end

    scope "publications" do
      root to: "publications#index", as: :publications
      scope ":publication_category" do
        root to: "publications#index", as: "publications_category"
        get ":id", to: "publications#show", as: :publication
      end

    end

    scope "partners" do
      get ":id", to: "partners#show", as: :partner
    end
  end

  match "*url", to: "application#not_found", via: [:get, :post, :put, :update, :delete]
end
