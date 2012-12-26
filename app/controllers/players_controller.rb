class PlayersController < ApplicationController

	def index
		@players = Player.get_all_players
	end

  def new
  	
  end
end
