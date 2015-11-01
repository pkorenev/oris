class CreatePartnersProjects < ActiveRecord::Migration
  def change
    create_table :partners_projects do |t|
      t.belongs_to :project
      t.belongs_to :partner
    end
  end
end
