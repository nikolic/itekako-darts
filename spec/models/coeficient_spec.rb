# == Schema Information
#
# Table name: coeficients
#
#  id         :integer          not null, primary key
#  value      :integer
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Coeficient do
  before do
  	@coef = FactoryGirl.create :coeficient
  end

  subject { @coef }

  describe "Check validation" do
    it { should be_valid }
  end

  coeficient_fields = [
      :value,
      :active
    ]

  describe "Check fields" do
    coeficient_fields.each do |field|
  	  it { should respond_to field}
    end
  end
end
