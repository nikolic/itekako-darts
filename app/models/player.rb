class Player < ActiveRecord::Base
  attr_accessible :name

  def self.get_all_players
    return self.all
   end
end
