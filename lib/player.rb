require_relative 'weapon'

class Player

	attr_reader :name, :weapon_choice

	def initialize(name, weapon_class=Weapons )
		@name = name
		@weapon_choice = nil
		@weapon_class = weapon_class
	end

	def chooses(weapon)
		@weapon_choice = @weapon_class.new(weapon)
	end

	def fights(opponent)

		if @weapon_choice.beats?(opponent.weapon_choice) 
			:winner  
		elsif @weapon_choice.type == opponent.weapon_choice
			:draw
		else
		  :loser
		end

	end

end