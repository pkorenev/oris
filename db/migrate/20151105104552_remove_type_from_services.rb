class RemoveTypeFromServices < ActiveRecord::Migration
  def change
    remove_column :services, :type, :string
  end
end
