class CreateHomeCompanyFeedbacks < ActiveRecord::Migration
  def up
    create_table :home_company_feedbacks do |t|
      t.string :company_name
      t.text :comment
      t.string :company_url

      t.timestamps null: false
    end

    HomeCompanyFeedback.create_translation_table!(company_name: :string, comment: :text, company_url: :text)
  end

  def down
    HomeCompanyFeedback.drop_translation_table!

    drop_table :home_company_feedbacks
  end
end
