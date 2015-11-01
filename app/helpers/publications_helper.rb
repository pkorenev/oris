module PublicationsHelper
  def categories_tabs
    if @categories_tabs.nil?

      category_id = @active_category.try(&:id)
      @categories_tabs = [{name: "Все публикации", url: publications_path, active: category_id.nil?}] + PublicationCategory.all.map{|c| {name: c.name, url: publications_category_path(c), active: c.id == category_id} }

    end

    @categories_tabs
  end
end