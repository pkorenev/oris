class AddServiceCategoryIdToServices < ActiveRecord::Migration
  def change
    add_column :services, :service_category_id, :integer
  end
end
