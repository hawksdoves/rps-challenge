require_relative 'weapon'

class Computer

	WEAPONS = ["Rock","Paper","Scissors"]

	attr_reader :name, :weapon_choice

	def initialize(weapon_class=Weapons)
		@name = "Computer"
		@weapon_choice = nil
		@weapon_class = weapon_class
	end



	def weapon		
		@weapon_choice = @weapon_class.new(WEAPONS.sample)
	end



end