class GamesController < ApplicationController

  def create
 
    player_ids = params[:players]

<<<<<<< HEAD
    if not player_ids.blank? 
      game = Game.create()
      Participation.create_participations(game.id, player_ids)
      redirect_to :controller => 'games', :action => 'index'
    else
      redirect_to :controller => 'games', :action => 'options'
    end 
      
=======
  	if not player_ids.blank? 
  		game = Game.create()
  		Participation.create_participations(game.id, player_ids)
  		redirect_to :controller => 'games', :action => 'index', :id => game.id
  	else
  		redirect_to :controller => 'games', :action => 'options'
  	end 
  		
>>>>>>> 6de11aabc57769890bb5e6748b733220500c3c61
  end


  def options
<<<<<<< HEAD
    @players = Player.all
    
=======
    @players = Player.get_all_players   
>>>>>>> 6de11aabc57769890bb5e6748b733220500c3c61
  end


  def index
    game_id = params[:id]
    @game = Game.find(game_id)
  end


  def show
    
  end

end
