class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :stockid, :make, :model, :year, :link, :link2, :link3, :link4 
      t.integer :dealer_id 
      t.timestamps
    end
  end
end
