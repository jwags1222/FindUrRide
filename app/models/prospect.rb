class Prospect < ActiveRecord::Base 

  has_many :car_prospects
  has_many :cars, through: :car_prospects 

end 