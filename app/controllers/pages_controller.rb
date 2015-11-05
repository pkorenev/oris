class PagesController < ApplicationController
  #before_action :set_page_instance
  def stub
    @phones = ["+7 7172 539 277", "+7 7172 539 275", "+7 7273 30 2323", "+7 7272 59 6263"]
    @mail = "info@orislegal.com"
    render layout: false
  end

  def index
    set_page_metadata("home")
    @projects = Project.published.limit(4)
    @events = Event.published.featured.order_by_event_date_asc

    @publications = categorized_index(nil, PublicationCategory, Publication, :publications).order_by_created_at_desc
  end

  def career

    @vacancies = Vacancy.published

    @total_vacancies_count = @vacancies.count

    @available_vacancies_count_string = "Доступно #{@total_vacancies_count} вакансий"

    @vacancy_request = VacancyRequest.new

    set_page_metadata("career")
  end

  def contact
    set_page_metadata("contact")
    @offices = Office.published
  end

  def about
    set_page_metadata("about")
    @partners = Partner.published
  end

  def page_class
    class_name = "Pages::#{params[:action].classify}"
    class_name.constantize
  end

  def set_page_instance
    @page = page_class.first
  end

  def search
    search = Sunspot.search(Project::Translation, Publication::Translation,\
                            Service::Translation, Event::Translation) do
      with  :locale, I18n.locale
      fulltext params[:s], highlight: true
      paginate page: params[:page] || 1, per_page: 5
    end

    @results = search.results
  end
end
