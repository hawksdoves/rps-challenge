require_relative 'player'

class Game

	attr_reader :player_1, :player_2

	def initialize(player_1)
		@player_1 = player_1
		@player_2 = nil
		@winner = nil
		@hands = Array.new
	end

	def self.create(player_1)
		@game = Game.new(player_1)
	end

	def self.instance
		@game
	end

	def add_player(player_2)
		@player_2 = player_2
	end

	def winner
		@winner 	
	end 

	def find_winner(player1_hand, player2_hand)
  		winning_moves = {
    					'Rock' => 'Scissors',
    					'Scissors' => 'Paper',
    					'Paper' => 'Rock'
  										}  
  		return @winner = 'Draw' if player1_hand.my_hand == player2_hand.my_hand
  		winning_moves[player1_hand.my_hand] == player2_hand.my_hand ? @winner = player1_hand.name : @winner = player2_hand.name
	end

end
