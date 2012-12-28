require 'spec_helper'

describe Coeficient do
  before do
  	let(:coef) {FactoryGirl.create :coficient}
  end

  subject { coef }

  describe "Check validation" do
    it { should be_valid }
  end

  player_fields = [
      :value,
      :active
    ]

  describe "Check fields" do
    player_fields.each do |field|
  	  it { should respond_to field}
    end
  end
end
