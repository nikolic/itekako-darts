# Coeficient Model for storing point caliculation coeficients
#
# @attr [Integer] value Coeficient Value
# @attr [Boolean] active Boolean to show if the coeficient should be
#   used to calculate points in new games
#
class Coeficient < ActiveRecord::Base
  attr_accessible :value, :active  
  has_many :games


  # Static method for creating a new coeficient.
  # 
  # @note Before creating a new Coeficient, it first deactivates all active ones 
  #   to ensure that there will always be only one active coeficient
  # 
  # @param [Float] value Value of the new coeficient
  # @return [Coeficient] Newly created Coeficient object
  def self.new_with_value(value)
    old_coeficients = Coeficient.find_all_by_active(true)
    old_coeficients.each do |coef|
      coef.active = false
      coef.save
    end

    Coeficient.create :value => value, :active => true
  end
end
