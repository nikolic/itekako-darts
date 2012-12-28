require 'spec_helper'

describe Player do
  before do
    let(:player)  {Player.new :name => "Test User"}
  end

  subject { player }

  describe "Check validation" do
    it { should be_valid }
  end

  player_fields = [
      :name,
      :points
    ]

  describe "Check fields" do
    player_fields.each do |field|
  	  it { should respond_to field}
    end
  end
end
