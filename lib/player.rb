
class Player

	attr_reader :name, :my_hand

	def initialize(name)
		@name = name
		@my_hand = nil
	end

	def self.define(name)
		@person = Player.new(name)
	end

	def self.instance
		@person
	end

	def assign_hand(hand)
		@my_hand = hand
	end

end