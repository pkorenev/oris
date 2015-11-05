class ServicesController < ArticlesController
  def index
    if resource_class.blank?
      return redirect_to services_practices_path
    end

    @services_practices = ServicePractice.all.order_by_desc
    @services_departments = ServiceDepartment.all.order_by_desc

  end

  def show
    article = Service.first

    render layout: "article", article: article
  end

  def resource_class
    params[:resource_class].try{|c| c.constantize }
  end
end