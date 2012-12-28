class Player < ActiveRecord::Base
  attr_accessible :name
  has_many :participations

  def self.get_all_players
    return self.all
   end
end
