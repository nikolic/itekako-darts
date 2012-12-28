class Game < ActiveRecord::Base
  attr_accessible :coeficient, :doubles, :number_of_players
  belongs_to :coeficient
  has_many :participations
end
