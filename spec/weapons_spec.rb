require 'weapon'

describe Weapons do

subject(:weapon) {described_class.new("Rock")}
subject(:weapon1) {described_class.new("Paper")}	
subject(:weapon2) {described_class.new("Scissors")}	
subject(:weapon3) {described_class.new("Rock")}

	describe 'initialize' do

		it 'has the players weapon' do
			expect(weapon.type).to eq "Rock"
		end
		
	end

	describe '#beats?' do
		
		it 'returns false, as your weapon, Rock is beaten the weapon paper' do
			expect(weapon.beats?(weapon1)).to eq false
		end

		it 'returns false, as your weapon, Rock does not beat the weapon rock' do
			expect(weapon.beats?(weapon3)).to eq false
		end

		it 'returns true, as your weapon, Rock beats the weapon scissors' do
			expect(weapon.beats?(weapon2)).to eq true
		end

	end

end