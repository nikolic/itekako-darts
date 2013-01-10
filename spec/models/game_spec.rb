# == Schema Information
#
# Table name: games
#
#  id                :integer          not null, primary key
#  coeficient_id     :integer
#  number_of_players :integer
#  doubles           :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'spec_helper'

describe Game do
  before do
    @coeficient = FactoryGirl.create :coeficient
    @players = []
    8.times do
      @players.push FactoryGirl.create :player
    end
    @game = Game.start_new true, @players
  end

  subject { @game }

  describe "Check validation" do
    it { should be_valid }
  end

  game_fields = [
      :number_of_players,
      :coeficient_id,
      :doubles
    ]

  describe "Check fields" do
    game_fields.each do |field|
      it { should respond_to field}
    end
  end

  describe "Checking game mechanics" do
    before do
      # @game.add_players(@players)
      @game.position_teams [3,2,4,1]
    end

    it "should have 8 players" do
      @game.number_of_players.should eq 8
    end

    it "should have 2 players per team" do
      4.times do |i|
        @game.get_team(i+1).count.should eq 2
      end
    end

    it "should have correct team order" do
      @game.team_position(1).should eq 4
      @game.team_position(2).should eq 2
      @game.team_position(3).should eq 1
      @game.team_position(4).should eq 3
    end
  end
end
