class Dealership < ActiveRecord::Base 

  has_many :users
  has_many :cars

end 