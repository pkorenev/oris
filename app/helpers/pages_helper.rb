module PagesHelper
  def menu_items
    items = []
    keys = [:about, :projects, {key: :services, url: ServiceCategory.first.try(&:url) || services_path}, :publications, :events, :career, :contact]
    keys.each do |item|
      if !item.is_a?(Hash)
        item = {key: item.to_sym}
      end
      key = item[:key]
      item[:name] ||= (t("layout.menu.#{key}", raise: true) rescue key.to_s.humanize)
      item[:url] ||= send("#{key}_path")
      item[:active] ||= active_menu_item?(key)
      item[:clickable] ||= clickable_menu_item?(key)
      items << item
    end

    items
  end

  def active_menu_item?(key)
    item = params[:menu_item]
    item.present? && item.to_sym == key.to_sym
  end

  def clickable_menu_item?(key)
    is_root = params[:menu_item_root]
    !(is_root && params[:menu_item].try(&:to_sym) == key.to_sym)
  end

  def other_locale_link(current_locale = I18n.locale)
    current_locale = current_locale.to_sym

    other_locale = :en
    other_locale = :ru if current_locale == :en

    url = @locale_links[other_locale]
    locale_title = other_locale.to_s




    link_to(locale_title, url , class: "mow")
  end

  def html_block_with_fallback(key, from_page_instance = false, locale = I18n.locale, &block)
    page_instance = nil
    html_block = nil
    if from_page_instance == true
      page_instance = @page_instance
    elsif from_page_instance.is_a?(Page)
      page_instance = from_page_instance
    end

    page_instance.try do |p|
      html_block = p.html_blocks.by_field(key).first
    end

    if  (html_block || (html_block = KeyedHtmlBlock.by_key(key).first)) && html_block.content.present?
      return raw html_block.translations_by_locale[locale].content
    end

    if block_given?
      yield
      #self.instance_eval(&block)

    end

    nil

  end

  def page_heading
    if content_for?(:page_heading)
      return content_for(:page_heading)
    end

    if @page_class
      page_key = @page_class.name.demodulize.underscore
      title = (I18n.t("pages.#{page_key}.page_heading.name" , raise: true) rescue nil)
      description = (I18n.t("pages.#{page_key}.page_heading.description" , raise: true) rescue nil)
    end
    title ||= @page_metadata.try{|m| m[:title] }
    description ||= nil

    #return content_tag(:h1, @page_class.inspect)
    raw([(content_tag(:h3, title, class: "vt_s") if title.present?),
         (content_tag(:p, description, class: "vt_p") if description.present?)
        ].select(&:present?).join)
  end

  def order_service_request
    @order_service_request ||= OrderServiceRequest.new

    @order_service_request
  end
end
