class AddPublicationCategoryIdToPublications < ActiveRecord::Migration
  def change
    add_column :publications, :publication_category_id, :integer
  end
end
