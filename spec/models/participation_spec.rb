require 'spec_helper'

describe Participation do
  before do
  	let(:player) do
      FactoryGirl.new :player
    end

    let(:game) do
      FactoryGirl.new :game
    end

    let(:participation) do
      Participation.new(
          :player_id => player.id,
          :game_id => game.id,
          :team => 1,
          :position => 1
        )
    end
  end

  subject { participation }

  describe "Check validation" do
    it { should be_valid }
  end

  player_fields = [
      :number_of_players,
      :coefs,
      :doubles
    ]

  describe "Check fields" do
    player_fields.each do |field|
      it { should respond_to field}
    end
  end  
end