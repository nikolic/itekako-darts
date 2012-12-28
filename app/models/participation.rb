class Participation < ActiveRecord::Base
  attr_accessible :game_id, :player_id, :position

  def self.create_participations(game_id, player_ids)
    # to do validation
    player_ids.each do |id|
      Participation.create(:game_id => game_id, :player_id => id, :position => nil)
    end
  end

end
