require 'hand'

describe Hand do

let(:player_1) {double :player, :name => "Bob"}
subject(:hand) {described_class.new("rock",player_1)}
	
	describe 'initialize' do

		it 'has the players weapon' do
			expect(hand.my_weapon).to eq "rock"
		end

		it 'has the opponents weapon as nil' do
			expect(hand.opponent_weapon).to eq nil
		end

		it 'assigns which player\'s hand it is' do
			expect(hand.player1).to eq player_1
		end
		
	end

	describe '#weapon' do
		
		it 'picks rock, paper or scissors' do
			allow(Hand::WEAPONS).to receive(:sample).and_return("Paper")
			expect(hand.computer_weapon).to eq 'Paper'

		end
	end

	describe '#winner' do

		it 'returns the winner\'s name' do
			allow(Hand::WEAPONS).to receive(:sample).and_return("Paper")
			hand.computer_weapon
			expect(hand.winner).to eq 'The Computer'
		end

	end

end