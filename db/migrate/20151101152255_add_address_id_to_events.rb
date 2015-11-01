class AddAddressIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_address_id, :integer
  end
end
