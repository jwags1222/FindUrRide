class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|

      t.string :mls_number, :agent, :street_address, :link, :city, :state, :zip  
      t.timestamps


    end
  end
end
