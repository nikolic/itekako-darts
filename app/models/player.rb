# Player Model for storing player information
#
# @attr [String] name Name of the player
#
class Player < ActiveRecord::Base
  attr_accessible :name
  has_many :participations

  # Static wrapper for getting all players
  # 
  # @return [Array<Player>] Array of all players
  def self.get_all_players
    return self.all
  end

# -----------------------------------------------------------------------------
# Rating Methods
# -----------------------------------------------------------------------------
  # Gets total ratings of all players
  # 
  # @return [Float] Rating of all players rounded to two digits
  def self.all_ratings
    rating = 0
    Player.all.each do |player|
      rating += player.rating
    end
    rating.round 2
  end

  # Gets this players rating
  # 
  # @return [Float] Rating of this player
  def rating
    position_sum = 0
    games = []
    number_of_teams = 0
    Participation.find_all_by_player_id(self.id).each do |participation|
      position_sum += participation.position
      games.push Game.find(participation.game_id)
    end

    games.each do |game|
      number_of_teams += game.number_of_teams
    end

    if position_sum == 0
      position_sum = number_of_teams.to_f-0.5
    end

    (1 - position_sum.to_f/number_of_teams).round 2
  end

# -----------------------------------------------------------------------------
# Points Methods
# -----------------------------------------------------------------------------

  # Gets total sum of points of all players
  # 
  # @return [Float] Total sum of points of all players ever
  def self.all_points
    points = 0
    Player.all.each do |player|
      points += player.points
    end
    points.round 2
  end

  # Gets the points this player made in games between two dates
  # 
  # @param [DateTime] date_start Date to start the calculation from
  # @param [DateTime] date_end Date to end the calculation with
  # @return (see #points) between two dates
  def points_between(date_start, date_end)
    points = 0
    games = Game.all
    games.each do |game|
      if (date_start..date_end).cover? game.created_at
        points += self.points game
      end
    end
    points
  end

  def points_this_month
    points = 0
    games = games_this_month
    games.each do |game|
      points += self.points game
    end
    points
  end

  # Gets the points this player has to date or in a certin game
  # 
  # @param [Game] game Game for which the points are calculated. 
  #   If nil points will be calculated for all games
  # @return [Float] points the player has accumulated
  def points(game = nil)
    points = 0

    if game
      coeficient = Coeficient.find(game.coeficient_id)
      get_participation_by_game game do |participation|
        opponents = get_opponents(game)

        points = points_formula(
            coeficient.value,
            game.number_of_teams,
            participation.position,
            opponents
          )
      end
    else
      Participation.find_all_by_player_id(self.id).each do |participation|
        game = Game.find(participation.game_id)
        coeficient = Coeficient.find(game.coeficient_id)
        opponents = get_opponents(game)

        points = points_formula(
            coeficient.value,
            game.number_of_teams,
            participation.position,
            opponents
          )
      end
    end
    points
  end

# -----------------------------------------------------------------------------
# Position Methods
# -----------------------------------------------------------------------------

  # Sets playeyers position in a game
  # 
  # @param [Game] game Refernce to a game in which position is being set
  # @param [Integer] position Position of a player in the @game
  def set_position_in_game(game, position)
    get_participation_by_game game do |participation|
      participation.position = position
      participation.save
    end
  end

  # Gets player position in a game
  # 
  # @param [Game] game The game for which the position is being set
  # @return [Integer] Position of a player in the game
  def get_position_in_game(game)
    position = 0
    get_participation_by_game game do |participation|
        position = participation.position
    end
    position
  end

  # Gets opponents of a player in a game
  # 
  # @param [Game] game Game for which opponents are found
  # @return [Array<Player>] Array of opponent players in the game
  def get_opponents(game)
    opponents = []
    game.get_players.each do |player|
      if player.get_team(game) != self.get_team(game)
        opponents.push player
      end
    end
    opponents
  end

  # Gets the number of the player's team in a game
  # 
  # @param [Game] game Game for which the team is found
  # @return [Integer] Number of the players team in a game
  def get_team(game)
    team = 0
    get_participation_by_game game do |participation|
        team = participation.team
    end
    team
  end

  private

    def games_this_month
      games =[]
      participations = Participation.find_all_by_player_id_and_created_at(
          self.id,
          (DateTime.now.beginning_of_month..DateTime.now)
        )
      participations.each do |participation|
        games.push Game.find participation.game_id
      end
      games
    end

    def games
      games =[]
      participations = Participation.find_all_by_player_id self.id
      participations.each do |participation|
        games.push Game.find participation.game_id
      end
      games
    end

    # Private method for getting the participation information 
    #   about the player in a game
    # 
    # @param [Game] game Game for which the participation information is found
    # @yieldparam [Participation] participation Participation that was found
    def get_participation_by_game(game)
      Participation.find_all_by_game_id(game.id).each do |participation|
        if self.id == participation.player_id
          yield participation
          break
        end      
      end
    end

    # Private method for calculating player's points
    #   Function for claculation is as follows
    #     points = coeficient * number_of_teams / position * a
    #     a = SUM(opponent.rating) / SUM(player.rating)
    #     player.rating = 1 - SUM(player.position) / SUM(number_of_teams)
    # 
    # @param [Float] coeficient Custom coeficient for points calculation
    # @param [Integer] number_of_teams Number of teams participating in a game
    # @param [Integer] position Position of a player in a game
    # @param [Array<Player>] opponents Array of players opponents
    # @return [Float] Points player has earned in a particular game as defined by
    def points_formula(coeficient,number_of_teams,position, opponents)
      if position == 0
        return 0
      end
      opponent_rating = 0
      opponents.each do |opponent|
        opponent_rating += opponent.rating
      end
      opponent_rating /= Player.all_ratings
    	p = (
        coeficient.to_f * number_of_teams.to_f / position * opponent_rating.to_f
      ).round 2
      p*100
    end
end