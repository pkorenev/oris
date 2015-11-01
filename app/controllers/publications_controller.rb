class PublicationsController < ApplicationController
  def index
    @publications = categorized_index(params[:publication_category], PublicationCategory, Publication, :publications).order_by_created_at_desc
  end

  def show
    collection = categorized_index(params[:publication_category], PublicationCategory, Publication, :publications).order_by_created_at_desc
    @publication = get_categorized_item(params[:id], PublicationCategory, Publication, :publications, :publication_category, collection)

  end
end