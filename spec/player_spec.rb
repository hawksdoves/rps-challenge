require 'player'

describe Player do

let(:class_weapon) {double :weapon }
let(:weapon) { double :weapon, type: "Rock" }
let(:weapon1) { double :weapon, type: "Scissors" }
let(:computer) {double :computer, name: "Computer", weapon_choice: weapon1 }

subject(:player) { described_class.new("Bob") }
	
	describe '#initialize' do

		it 'with a name' do
			expect(player.name).to eq "Bob"
		end

		it 'with no weapon choice' do
			expect(player.weapon_choice).to eq nil
		end
	end

	describe '#chooses' do

		it "assigns a weapon to weapon_choice" do
			player.chooses(weapon)
			expect(player.weapon_choice.type).to eq weapon
		end

	end

	describe '#fights' do

		it 'returns winner when you have won' do
			allow(weapon).to receive(:beats?).with(weapon1).and_return(true)
			#allow(class_weapon).to receive(:new).with(weapon)
			player.chooses(weapon)
			expect(player.fights(computer)).to eq :winner
		end

		it 'returns loser when you have lost' do
			player.chooses(weapon)
			expect(player.fights(computer)).to eq :loser
		end

		it 'returns draw when you have drew' do
			player.chooses(weapon)
			expect(player.fights(computer)).to eq :draw
		end

	end

end