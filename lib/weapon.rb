

class Weapons

	attr_reader :type


	def initialize(type)
		@type = type
	end

	def beats?(weapon)
		winning_moves = {
    					'Rock' => 'Scissors',
    					'Scissors' => 'Paper',
    					'Paper' => 'Rock'
  										} 
		winning_moves[@type] == weapon.type
	end

end