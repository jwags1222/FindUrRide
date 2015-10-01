class CarProspect < ActiveRecord::Base 
  belongs_to :car
  belongs_to :prospect 

end 