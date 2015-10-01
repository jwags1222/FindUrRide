class AddNameToDealerships < ActiveRecord::Migration
  def change
 add_column :dealerships, :name, :string 
  end
end
