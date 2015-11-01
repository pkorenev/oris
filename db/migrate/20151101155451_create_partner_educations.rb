class CreatePartnerEducations < ActiveRecord::Migration
  def up
    create_table :partner_educations do |t|
      t.belongs_to :partner
      t.string :school_name
      t.string :degree

      t.timestamps null: false
    end

    PartnerEducation.create_translation_table!(school_name: :string, degree: :string)
  end

  def down
    PartnerEducation.drop_translation_table!
    drop_table :partner_educations
  end
end
