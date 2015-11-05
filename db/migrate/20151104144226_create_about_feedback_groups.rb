class CreateAboutFeedbackGroups < ActiveRecord::Migration
  def up
    create_table :about_feedback_groups do |t|
      t.string :name
      t.has_attached_file :avatar

      t.timestamps null: false
    end

    AboutFeedbackGroup.create_translation_table!(name: :string)
  end

  def down
    AboutFeedbackGroup.drop_translation_table!

    drop_table :about_feedback_groups
  end
end
