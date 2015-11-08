class CreateSubcriptionRequests < ActiveRecord::Migration
  def change
    create_table :subcription_requests do |t|
      t.string :email

      t.timestamps null: false
    end
  end
end
