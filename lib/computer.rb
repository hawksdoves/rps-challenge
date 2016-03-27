class Computer

	WEAPONS = ["Rock","Paper","Scissors"]

	attr_reader :name, :weapon_choice

	def initialize
		@name = "Computer"
		@weapon_choice = nil
	end

	def weapon		
		@weapon_choice = WEAPONS.sample
	end

end