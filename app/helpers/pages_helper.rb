module PagesHelper
  def menu_items
    items = []
    keys = [:about, :projects, {key: :services, url: services_practices_path}, :publications, :events, :career, :contact]
    keys.each do |item|
      if !item.is_a?(Hash)
        item = {key: item.to_sym}
      end
      key = item[:key]
      item[:name] ||= t("layout.menu.#{key}")
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
end
