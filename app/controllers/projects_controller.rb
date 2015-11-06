class ProjectsController < ApplicationController
  def index
    @projects = categorized_index(params[:project_category], ProjectCategory, Project, :projects)
    @total_projects_by_query_count = @projects.count


    @practices = ServiceCategory.first.try{|c| c.services } || []
    @departments = ServiceCategory.second.try{|c| c.services } || []
  end

  def show
    collection = categorized_index(params[:project_category], ProjectCategory, Project, :projects)
    @project = get_categorized_item(params[:id], ProjectCategory, Project, :publications, :projects, collection)
    @next_project = @next_article
    @prev_project = @prev_article

    if @project.nil?
      render_not_found
    end
  end
end