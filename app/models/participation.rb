class Participation < ActiveRecord::Base
  attr_accessible :game, :player, :position, :team

  belongs_to :game
  belongs_to :player

  def self.create_participations(game_id, player_ids)
    # to do validation
    player_ids.each do |id|
      Participation.create(:game => game_id, :player => id, :position => nil)
    end
  end

end
