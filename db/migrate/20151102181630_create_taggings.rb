class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.belongs_to :tag
      t.string :taggable_type
      t.string :taggable_field_name
      t.integer :taggable_id
    end
  end
end
