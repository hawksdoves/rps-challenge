require_relative 'player'

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

	def opponents_hand(my_hand)
		  opponent_hand = @hands.select {|hand| hand.name != my_hand.name }
		  opponent_hand[0]
	end

	def reset_hands
		@hands.clear
	end

end