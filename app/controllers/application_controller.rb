class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  include PagesHelper

  before_action :set_locale, unless: -> { controller_path.scan(/\Adevise/).any? || controller_path.scan(/\Arails_admin/).any? }

  before_action :init_locale_links

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



  def set_locale(force = true)
    if !params[:controller].match(/^rails_admin/) && !(params[:controller] == 'error')
      params_locale = params[:locale]
      params_predefined_locale = params[:predefined_locale]
      locale = params_locale || params_predefined_locale

      cookies_locale = cookies[:locale]

      if !locale || !I18n.available_locales.include?(locale.to_sym)
        locale = cookies_locale
      end

      if !locale || !I18n.available_locales.include?(locale.to_sym)
        locale = http_accept_language.compatible_language_from(I18n.available_locales)
      end

      if locale != cookies_locale
        cookies[:locale] = {
            value: locale,
            expires: 1.year.from_now
        }
      end

      #render inline: "locale: #{locale.inspect}"

      #logger.debug "locale: #{locale.inspect}"
      #logger.debug "params_locale: #{params_locale.inspect}"
      #logger.debug "cookies_locale: #{cookies_locale.inspect}"

      #return render inline: "#{locale != params_locale}"
      if locale != params_locale && locale != params_predefined_locale && force
        redirect_to locale: locale, :status => :moved_permanently
      else
        I18n.locale = locale
      end
    elsif params[:controller].match(/^rails_admin/)
      I18n.locale = :uk
    end

  end


  def set_locale_links
    @locale_links = []
    I18n.available_locales.select{|l| l != I18n.locale }.each do |locale|
      @locale_links[locale.to_sym] = url_for(locale: locale)
    end
  end

  def init_locale_links(resource = nil)
    @locale_links ||= {}
    I18n.available_locales.each do |locale|
      if resource
        url = resource.url(locale)
      else
        url = url_for locale: locale
      end
      @locale_links[locale.to_sym] = url
    end

  end


  def about_section

  end

  def set_page_metadata(page = nil)
    page_class_name = nil
    page_instance = nil
    if page
      case page
        when String
          page_class_name = "Pages::#{page.camelize}"
      end
      page_class = page_class_name.constantize rescue nil

      if page.is_a?(ActiveRecord::Base)
        page_instance = page
        if page_instance.respond_to?(:has_seo_tags?) && page_instance.has_seo_tags?
          @page_metadata = page_instance.seo_tags
        end
      end
    else
      page_class = params[:page_class_name].try(&:constantize)
    end



    @page_class = page_class
    page_instance ||= page_class.try(&:first)
    @page_metadata ||= page_instance.try(&:seo_tags)

    @page_metadata ||= { head_title: page_class.try(&:default_head_title) }

    if @page_metadata[:head_title].blank?
      if page_instance.respond_to?(:name)
        @page_metadata[:head_title] = page_instance.name
      end
    end

    @page_instance = page_instance
  end


  def pjax?
    !request.headers['X-PJAX'].nil?
  end

  def index
    render layout: false if pjax?
  end
end
