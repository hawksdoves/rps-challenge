require_relative 'player'

class Hand 

	attr_reader :my_weapon, :player

	def initialize(my_weapon, player)
		@my_weapon = my_weapon
		@player = player
	end

	def self.hand(my_weapon, player)
		@hand = Hand.new(my_weapon, player)
	end

	def self.instance
		@hand 
	end

	def reset_my_hand
		@my_weapon = nil
	end

	def weapon		
		num = random_gen		
		if num==1
			@opponent_weapon = 'Rock'
		elsif num==2
			@opponent_weapon ='Paper'
		else
			@opponent_weapon = 'Scissors'
		end
	end

	def random_gen
		Kernel.rand(1..3)
	end

end