class VacanciesController < ApplicationController
  def show
    @article = Vacancy.translation_class.where(url_for: params[:vacancy_id])



    render layout: "article", locals: {article: @article, prev_article: @prev_article, next_article: @next_article}
  end

  def index
    @vacancies = Vacancy.published

    @total_vacancies_count = @vacancies.count

    @available_vacancies_count_string = "Доступно #{@total_vacancies_count} вакансий"

    @vacancy_request = VacancyRequest.new

    set_page_metadata("career")
  end
end