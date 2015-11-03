class CreateClientsProjects < ActiveRecord::Migration
  def change
    create_table :clients_projects do |t|
      t.integer :client_id
      t.integer :project_id
    end
  end
end
