class StaticPagesController < ApplicationController

	def index
		@title = "Home page"
	end


	def players
		@title = "Players"
	end


	def game_mode
		@title = "Game mode"
	end


	def participants
		@title = "Participants"
	end


	def positioning
		@title = "Positioning"
	end


	def results
		@title = "Results"
	end

end
