class CreateDealerships < ActiveRecord::Migration
  def change
    create_table :dealerships do |t|
      t.string :streetaddress, :city, :state, :phonenumber, :twilionumber  
      t.timestamps 
    end
  end
end
