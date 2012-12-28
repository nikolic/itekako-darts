class Coeficient < ActiveRecord::Base
  attr_accessible :value, :active  
  has_many :games
end
