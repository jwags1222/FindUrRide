class CreateCarProspects < ActiveRecord::Migration
  def change
    create_table :car_prospects do |t|
      t.integer :car_id, :prospect_id 
      t.timestamps
    end
  end
end
