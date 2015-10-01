class CreateProspects < ActiveRecord::Migration
  def change
    create_table :prospects do |t|
      t.timestamps
      t.string :name, :phonenumber, :test 
      
    end
  end
end
