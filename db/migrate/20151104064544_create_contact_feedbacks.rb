class CreateContactFeedbacks < ActiveRecord::Migration
  def change
    create_table :contact_feedbacks do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.text :message

      t.timestamps null: false
    end
  end
end
