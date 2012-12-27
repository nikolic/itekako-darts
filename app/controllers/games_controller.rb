class GamesController < ApplicationController

  def create_game
 
  	player_ids = params[:players]

  	if not player_ids.blank? 
  		game = Game.create()
  		Participation.create_participations(game.id, player_ids)
  		redirect_to :controller => 'static_pages', :action => 'index'
  	else
  		redirect_to :controller => 'players'
  	end 
  		
  end

end
