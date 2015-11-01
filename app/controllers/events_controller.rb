class EventsController < ApplicationController
  def index
    @featured_events = Event.published.featured.order_by_event_date_asc
    @completed_events = Event.published.completed.order_by_event_date_desc
  end

  def show
    url = params[:id]
    @event = Event.translation_class.where(url_fragment: url).first.try(&:item)
  end
end