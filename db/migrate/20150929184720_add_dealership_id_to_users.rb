class AddDealershipIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dealership_id, :integer 
  end
end
