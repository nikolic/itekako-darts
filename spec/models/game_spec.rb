require 'spec_helper'

describe Game do
  before do
  	let(:coeficient) do
  	  FactoryGirl.new :coeficient
  	end

    let(:game) do
      Game.new(
          :coeficient_id => coeficient.id,
          :number_of_players => 4,
          :doubles => true
        )
    end
  end

  subject { game }

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
