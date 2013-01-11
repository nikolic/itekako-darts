class GamesController < ApplicationController

  def create
    # game = Game.create()
    player_ids = params[:players]
    doubles = false
    redir = {:controller => 'games', :action => 'options'}

    if not player_ids.blank?
      players = []
      player_ids.each do |id|
        players.push Player.find(id)
      end
    end
    begin
      doubles = true if params[:post][:category] == "1"
      game = Game.start_new doubles, players
      Participation.create_participations(game, players)
      redir = {:controller => 'games', :action => 'index', :id => game.id}
    rescue Exception => e
      puts "ERROR! >>> #{e.message}"
      flash[:error] = e.message
    end
    redirect_to redir
  end

  def options
    @players = Player.all
  end


  def index
    @game = Game.find params[:id]
  end

  def calculate
    @game = Game.find(params[:game_id])
    teams = params[:team_id]
    @game.position_teams teams

    redirect_to results_path :game_id => params[:game_id]
  end

  def show
    
  end

end
