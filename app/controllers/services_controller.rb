class ServicesController < ArticlesController
  def index
    if params[:service_category].blank?
      return redirect_to ServiceCategory.first.url
    end

    @services = categorized_index(params[:service_category], ServiceCategory, Service, :services)

    init_locale_links(@active_category)




    # @services_practices = ServicePractice.all.order_by_desc
    # @services_departments = ServiceDepartment.all.order_by_desc

  end

  def show
    collection = categorized_index(params[:service_category], ServiceCategory, Service, :services)

    @article = get_categorized_item(params[:id], ServiceCategory, Service, :services, :service_category, collection)

    if @article.nil?
      return render_not_found
    end

    init_locale_links(@article)

    render layout: "article", article: @article
  end

  def resource_class
    params[:resource_class].try{|c| c.constantize }
  end
end