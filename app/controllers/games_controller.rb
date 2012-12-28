class GamesController < ApplicationController

  def create
 
    player_ids = params[:players]

  	if not player_ids.blank? 
  		game = Game.create()
  		Participation.create_participations(game.id, player_ids)
  		redirect_to :controller => 'games', :action => 'index'
  	else
  		redirect_to :controller => 'games', :action => 'options'
  	end 
  		
  end

  def show
    
  end

  def options
    @players = Player.get_all_players
    
  end

  def index
    
  end


end
