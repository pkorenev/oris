class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  def default_url_options
    {locale: I18n.locale}
  end

  def not_fount
    render "not_found", status: 404
  end

  def categorized_index(category_url_fragment, category_class, resource_class, association_name)
    @active_category_url_fragment = category_url_fragment
    @active_category = category_class.translation_class.where(url_fragment: @active_category_url_fragment).first.try(&:item)
    if @active_category
      resources = @active_category.send(association_name)
    else
      resources = resource_class.all
    end

    resources = resources.published

    resources
  end

  def get_categorized_item(url, category_class, resource_class, child_association_name, parent_association_name, collection = nil)
    resource = resource_class.translation_class.where(url_fragment: url).first.try(&:item)

    if resource
      resources = collection
      resources ||= categorized_index(resource.send(parent_association_name).url_fragment, category_class, resource_class, child_association_name)
      #@publications = @publication.publication_category.publications.published.order_by_created_at_desc
      active_index = nil
      resources.each_with_index do |item, index|
        if item.id == resource.id
          active_index = index
          break
        end
      end

      prev_index = active_index - 1
      next_index = active_index + 1

      if resources.count < next_index + 1
        next_index = 0
      end

      if prev_index < 0
        prev_index = resources.count - 1
      end

      @prev_article = resources[prev_index]
      @next_article = resources[next_index]
    end

    resource
  end

  def render_not_found
    render "not_found", status: 404
  end

  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
