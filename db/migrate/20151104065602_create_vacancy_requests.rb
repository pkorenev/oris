class CreateVacancyRequests < ActiveRecord::Migration
  def change
    create_table :vacancy_requests do |t|
      t.belongs_to :vacancy
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.has_attached_file :cv
      t.string :site_url
      t.string :social_link
      t.text :description

      t.timestamps null: false
    end
  end
end
