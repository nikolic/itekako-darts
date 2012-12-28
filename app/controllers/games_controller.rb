class GamesController < ApplicationController

  def create
 
    player_ids = params[:players]

  	if not player_ids.blank? 
  		game = Game.create()
  		Participation.create_participations(game.id, player_ids)
  		redirect_to :controller => 'games', :action => 'index', :id => game.id
  	else
  		redirect_to :controller => 'games', :action => 'options'
  	end 
  end


  def options
    @players = Player.all
  end


  def index
    game_id = params[:id]
    @game = Game.find(game_id)
  end


  def show
    
  end

end
