class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fname, :mname, :lname, :password, :email, :cellphone  
      t.integer :dealer_id 
    end
  end
end
