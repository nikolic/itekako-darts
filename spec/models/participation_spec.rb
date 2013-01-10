# == Schema Information
#
# Table name: participations
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  game_id    :integer
#  position   :integer
#  team       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Participation do
  before do
  	@player = FactoryGirl.create :player

    @game = FactoryGirl.create :game

    @participation = Participation.new(
        :player_id => @player.id,
        :game_id => @game.id,
        :team => 1,
        :position => 1
      )
  end

  subject { @participation }

  describe "Check validation" do
    it { should be_valid }
  end

  participation_fields = [
      :player_id,
      :game_id,
      :team,
      :position
    ]

  describe "Check fields" do
    participation_fields.each do |field|
      it { should respond_to field}
    end
  end  
end
