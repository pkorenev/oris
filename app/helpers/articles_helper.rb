module ArticlesHelper
  def categories_tabs(category_class, index_path, include_show_all_tab = true)
    if @categories_tabs.nil?

      category_id = @active_category.try(&:id)
      @categories_tabs = []
      if include_show_all_tab
        @categories_tabs << {name: "Все публикации", url: index_path, active: category_id.nil?}
      end
      @categories_tabs += category_class.all.map{|c| {name: c.name, url: c.url, active: c.id == category_id} }

    end

    @categories_tabs
  end

  def categories_tabs_row(*args, **options)

    tabs = categories_tabs(*args)
    render partial: "helpers/articles/categories_tabs_row", locals: { tabs: tabs, options: options }
  end
end