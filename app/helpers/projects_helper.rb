module ProjectsHelper
  def total_projects_count
    if @total_projects_count_string.nil?
      number = @total_projects_by_query_count
      str = "#{number} проектов"

      @total_projects_count_string = str
    end


    @total_projects_count_string
  end
end