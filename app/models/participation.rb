class Participation < ActiveRecord::Base
  attr_accessible :game_id, :player_id, :position
end
