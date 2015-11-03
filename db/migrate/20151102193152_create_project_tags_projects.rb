class CreateProjectTagsProjects < ActiveRecord::Migration
  def change
    create_table :project_tags_projects do |t|
      t.belongs_to :project
      t.belongs_to :project_tag
    end
  end
end
