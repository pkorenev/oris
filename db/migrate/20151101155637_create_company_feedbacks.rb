class CreateCompanyFeedbacks < ActiveRecord::Migration
  def up
    create_table :company_feedbacks do |t|
      t.belongs_to :partner
      t.string :name
      t.text :comment
      t.string :company_url

      t.timestamps null: false
    end

    CompanyFeedback.create_translation_table!(name: :string, comment: :string, company_url: :string)
  end

  def down
    CompanyFeedback.drop_translation_table!
    drop_table :company_feedbacks
  end
end
