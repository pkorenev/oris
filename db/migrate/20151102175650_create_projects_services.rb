class CreateProjectsServices < ActiveRecord::Migration
  def change
    create_table :projects_services do |t|
      t.belongs_to :project
      t.belongs_to :service
    end
  end
end
