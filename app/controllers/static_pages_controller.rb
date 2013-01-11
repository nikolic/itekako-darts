class StaticPagesController < ApplicationController

  def index

  end


  def players

  end


  def game_mode

  end


  def participants

  end


  def positioning

  end


  def results
    @players = Player.get_all_players.sort_by {|player| -player.points_this_month}
     if not params[:game_id].blank?
       @game = Game.find params[:game_id]
     else
       @game = nil
     end
  end

end
