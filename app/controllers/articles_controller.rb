class ArticlesController < ApplicationController
  def index
    @resources = resource_class.all.order_by_desc
  end

  def resource_class

  end
end