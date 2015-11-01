class PublicationsController < ApplicationController
  def index
    @active_category_url_fragment = params[:publication_category]
    @active_category = PublicationCategory.translation_class.where(url_fragment: @active_category_url_fragment).first.try(&:item)
    if @active_category
      @publications = @active_category.publications
    else
      @publications = Publication.all
    end

    @publications = @publications.published.order_by_created_at_desc
  end

  def show
    url = params[:id]
    @publication = Publication.translation_class.where(url_fragment: url).first.try(&:item)

    if @publication
      @publications = @publication.publication_category.publications.published.order_by_created_at_desc
      active_index = nil
      @publications.each_with_index do |item, index|
        if item.id == @publication.id
          active_index = index
          break
        end
      end

      prev_index = active_index - 1
      next_index = active_index + 1

      if @publications.count < next_index + 1
        next_index = 0
      end

      if prev_index < 0
        prev_index = @publications.count - 1
      end

      @prev_article = @publications[prev_index]
      @next_article = @publications[next_index]
    end
  end
end