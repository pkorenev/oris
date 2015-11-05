class CreateOrderServiceRequests < ActiveRecord::Migration
  def change
    create_table :order_service_requests do |t|
      t.string :company_name
      t.string :activity_scope
      t.string :contact_person
      t.string :phone
      t.string :email
      t.text :description

      t.timestamps null: false
    end
  end
end
