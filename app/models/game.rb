# Game Model for storing game information
#
# @attr [Integer] coeficient_id ID of the referent coeficient
# @attr [Integer] number_of_players Number of the players in a game
# @attr [Boolean] doubles Is the game played in two=player team mode
# @attr [DateTime] created_at Timestamp when the game was created
# @attr [DateTime] updated_at Timestamp when the game was last updated
class Game < ActiveRecord::Base
  attr_accessible :coeficient_id, :doubles, :number_of_players
  belongs_to :coeficient
  has_many :participations


  # Creates a new game
  # 
  # @param [Boolean] doubles Is the game played in two-player team mode
  # @param players (see #add_players)
  # @return [Game] The new Game object instance
  def self.start_new(doubles, players)
    coef = Coeficient.find_by_active true
    game = Game.create(
        :coeficient_id => coef.id,
        :number_of_players => 0,
        :doubles => doubles
      )
    game.add_players players
    game
  end

  # Gets general information about this game instance
  # 
  # @return [Hash] A hash with some basic info about the game instace
  def info
  	coef = Coeficient.find(self.coeficient_id)
    {
      "id" => self.id,
      "number_of_players" => self.number_of_players,
      "doubles" => self.doubles,
      "coeficient" => coef.value
    }
  end

  # Adds players to the game
  # 
  # @note this method calls the {#pair_players} method if game is in doubles mode
  # 
  # @param [Array<Player>] players Array of players
  # @raise [ArgumentError] if players array is empty or nil
  def add_players(players)
    if !players || players.count == 0
      raise ArgumentError, "There must be at least one player in a game"
    end
    Participation.create_participations self, players
    pair_players if self.doubles
  end

  # Sets team positionig in game
  # 
  # @param [Array<Integer>] teams Array of teams. Order of team numbers within the 
  #   array determens the positioning order
  def position_teams(teams)
    if !teams || teams.count == 0
      raise ArgumentError, "There must be at least one team to position"
    end
    position = 1
    teams.each do |t|
      players = get_team t
      players.each do |player|
        player.set_position_in_game self, position
      end
      position+=1
    end
  end

  # Sets team positionig in game
  # 
  # @deprecated Use {#position_teams} instead
  # 
  # @param [Array<Player>] players Array of players. Order of players within the 
  #   array determens the positioning order
  def position_players(players)
    if !players || players.count == 0
      raise ArgumentError, "There must be at least one player to position"
    end
    position = 1
    players.each do |player|
      player.set_position_in_game self, position
      position+=1
    end
  end

  # Gets the number of teams in a game
  # 
  # @return [Integer] Number of teams in a game. Depends of the game's 
  #   {#doubles} attribute
  def number_of_teams
    if self.doubles
      self.number_of_players/2
    else
      self.number_of_players
    end
  end

  # Gets players of a specific team in game instace
  # 
  # @param [Integer] team Team number
  # @return [Array<Player>] Array of players
  def get_team(team)
    players = []
    get_particpations do |participation|
      players.push Player.find(participation.player_id) if participation.team == team
    end
    players
  end

  # Gets players order list for a game instance
  # 
  # @return (see #get_team)
  def get_player_list
    list = []
    teams = shuffle_teams
    teams.each do |team|
      list.push self.get_team(team)[0]
    end
    if self.doubles
      teams.each do |team|
        list.push self.get_team(team)[1]
      end
    end
    list
  end

  # Gets list of teams
  # 
  # @return (see #get_team)
  def get_team_list
    list = []
    teams = shuffle_teams
    teams.each do |team|
      list.push self.get_team team
    end
    list
  end

  # Gets all players in this game
  # 
  # @return (see #get_team)
  def get_players
    players = []
    get_particpations do |participation|
      players.push Player.find(participation.player_id)
    end
    players
  end

  # Gets a position of a team in a game instance
  # 
  # @param team (see #get_team)
  # @return [Integer] Position of a team in a game instance
  def team_position(team)
    position = 0
    get_particpations do |participation|
      if participation.team == team
        position = participation.position
        break
      end
    end
    position
  end

  private

    # Gets participations for this game
    # 
    # @yieldparam [Participation] participation Participation found
    #   for this game
    def get_particpations
      participations = Participation.find_all_by_game_id self.id
      participations.each do |participation|
        yield participation
      end
    end

    # Pairs players into two-player teams
    def pair_players
      if self.number_of_players % 2 == 0
        number_of_teams = self.number_of_players / 2
        teams = Array(1..number_of_teams)
        players = self.get_players

        while players.count > 0 do
          team_mates = players.sample 2
          team = teams.sample
          teams.delete team
          team_mates.each do |mate|
            part = Participation.get_for(mate, self)
            part.team = team
            part.save
            players.delete mate
          end
        end
      end
    end

  # Yields shuffled teams
  # 
  # @yield [Integer] Team number
  def shuffle_teams
    Array.new(self.number_of_teams){ |index| index+1}.shuffle
  end
end
