# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Player do
  before do
    @player = Player.create :name => "Test User"
  end

  subject { @player }

  describe "Checking validation" do
    it { should be_valid }
  end

  player_fields = [
      :name,
      :points,
      :set_position_in_game,
      :get_position_in_game
    ]

  describe "Checking fields" do
    player_fields.each do |field|
  	  it { should respond_to field}
    end
  end

  describe "Checking information" do
  	before do
      @start_date = DateTime.now
      @coeficient = Coeficient.new_with_value 3
      @player_2 = FactoryGirl.create :player
      @player_3 = FactoryGirl.create :player

      @game = Game.start_new false, [@player, @player_2]
      # @game.add_players [@player, @player_2]
      @game.position_players [@player, @player_2]

      @game_2 = Game.start_new false, [@player, @player_3, @player_2]
      # @game_2.add_players [@player, @player_3, @player_2]
      @game_2.position_players [@player_2, @player_3, @player]
      @end_date = DateTime.now
    end

    it "should be in position 1 in the first game" do
      @player.get_position_in_game(@game).should eq 1
    end

    it "should have 2.58 points in the first game" do
      @player.points(@game).should eq 2.58
    end

    it "hes opponent should have 0.65 points in the first game" do
      @player_2.points(@game).should eq 0.65
    end

    it "should have 4.93 points overall" do
      @player.points.should eq 4.93
    end

    it "should have 4.93 points in a time span" do
      @player.points_between(@start_date, @end_date).should eq 4.93
    end

    it "Total points of all players should be 13.61" do
      Player.all_points.should eq 13.61
    end

  end
end
