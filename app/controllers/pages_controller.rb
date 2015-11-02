class PagesController < ApplicationController
  def stub
    @phones = ["+7 7172 539 277", "+7 7172 539 275", "+7 7273 30 2323", "+7 7272 59 6263"]
    @mail = "info@orislegal.com"
    render layout: false
  end

  def index
    @projects = Project.published.limit(4)
    @events = Event.published.featured.order_by_event_date_asc

    @publications = categorized_index(nil, PublicationCategory, Publication, :publications).order_by_created_at_desc
  end

  def contact
    @offices = Office.published
  end

  def about
    @partners = Partner.published
  end
end
