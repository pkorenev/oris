class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :type
      t.string :url
    end

    Page


  end
end
