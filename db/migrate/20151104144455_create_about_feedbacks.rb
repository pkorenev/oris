class CreateAboutFeedbacks < ActiveRecord::Migration
  def up
    create_table :about_feedbacks do |t|
      t.belongs_to :feedback_group
      t.string :name
      t.text :description
    end

    AboutCompanyFeedback.create_translation_table!(name: :string, description: :text)

  end

  def down
    AboutCompanyFeedback

    drop_table :about_feedbacks
  end
end
