class CreateAboutPage < ActiveRecord::Migration
  def up
    create_table :about_pages do |t|
      t.text :team_html
      t.text :feedbacks_intro_html
      t.text :why_trust_us_html
      t.text :why_oris_html
      t.text :clients_and_partners_html

    end

    Pages::About.create_translation_table!(team_html: :text, feedbacks_intro_html: :text, why_trust_us_html: :text, why_oris_html: :text, clients_and_partners_html: :text)
  end

  def down
    Pages::About.dropo_translation_table!

    drop_table :about_pages
  end
end
