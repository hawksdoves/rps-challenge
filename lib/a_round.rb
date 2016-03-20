require_relative 'player'
require_relative 'game'
require_relative 'hand'

class Round 

	attr_reader :hands

	def initialize
		@hands = Array.new
	end

	def self.lets_play
		@round = Round.new
	end

	def self.instance
		@round
	end

	def hand_chosen(hand)
		@hands << hand
	end

	# def hands
	# 	@hands.dup
	# end	

	def opponents_hand(my_hand)
		  opponent_hand = @hands.select {|hand| hand.name != my_hand.name }
		  opponent_hand[0]
	end

	def reset_hands
		@hands.clear
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