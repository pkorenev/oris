class CreatePages < ActiveRecord::Migration
  def up
    create_table :pages do |t|
      t.string :type
      t.string :url
    end

    Cms::Page.create_translation_table!(url: :string)
  end

  def down
    Cms::Page.drop_translation_table!

    drop_table :pages
  end
end
