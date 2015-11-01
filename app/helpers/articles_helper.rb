module ArticlesHelper
  def categories_tabs(category_class, index_path)
    if @categories_tabs.nil?

      category_id = @active_category.try(&:id)
      @categories_tabs = [{name: "Все публикации", url: index_path, active: category_id.nil?}] + category_class.all.map{|c| {name: c.name, url: c.url, active: c.id == category_id} }

    end

    @categories_tabs
  end
end