class AddDealershipIdToCars < ActiveRecord::Migration
  def change
    add_column :cars, :dealership_id, :integer 
  end
end
