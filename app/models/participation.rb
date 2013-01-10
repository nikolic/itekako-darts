# Participation Model for relating players whith games
# 
# @attr [Integer] player_id ID of a player (unique)
# @attr [Integer] game_id ID of a game (unique)
# @attr [Integer] position Position of a player in a game
# @attr [Integer] team Team the player belogs to in a game
# @attr [DateTime] created_at Timestamp when the participation was created
# @attr [DateTime] updated_at Timestamp when the participation was last updated
class Participation < ActiveRecord::Base
  attr_accessible :game_id, :player_id, :position, :team

  belongs_to :game
  belongs_to :player

  validates_uniqueness_of :game_id, :scope => :player_id

  # Creates new participation for a game and an array of players
  # 
  # @note This initializes with one-player teams
  # 
  # @param [Game] game Game a players are participating in
  # @param [Array<Player>] players Array of players that are participating
  #   in a game
  def self.create_participations(game, players)
    # to do validation

    game.number_of_players = players.count
    game.save

    team = 1
    players.each do |player|
      Participation.create(
          :game_id => game.id,
          :player_id => player.id,
          :position => 0,
          :team => team
        )
      team += 1
    end
  end

  # def self.get_all_players(game)
  #   participations = Participation.find_all_by_game_id(game.id)
  #   players = []
  #   participations.each do |participation|
  #     players.push Player.find(participation.player_id)
  #   end
  #   players
  # end

  # Gets a Participation object for a Game- Player pair
  # 
  # @param [Player] player Player for which the participation is requested
  # @param [Game] game Game for which the participation is requested
  def self.get_for(player, game)
    participations = Participation.find_all_by_game_id(game.id)
    participations.each do |participation|
      if participation.player_id == player.id
        return participation
      end
    end
  end
end
