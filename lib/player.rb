
class Player

	attr_reader :name, :my_hand

	def initialize(name)
		@name = name
		@my_hand = nil
	end

	def assign_hand(hand)
		@my_hand = hand
	end

end