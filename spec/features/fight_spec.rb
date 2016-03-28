feature 'Fight' do
	
	scenario 'shows what weapons were picked' do
		allow(Computer::WEAPONS).to receive(:sample).and_return("Paper")
		sign_in_and_play
		click_button 'Rock'
		expect(page).to have_text('Paper beats Rock')
	end

	scenario 'Shows that you lost' do
		allow(Computer::WEAPONS).to receive(:sample).and_return("Paper")
		sign_in_and_play
		click_button 'Rock'
		expect(page).to have_text('You are the loser')
	end

	scenario 'Shows that you won' do
		allow(Computer::WEAPONS).to receive(:sample).and_return("Paper")
		sign_in_and_play
		click_button 'Scissors'
		expect(page).to have_text('You are the winner')
	end

	scenario 'Shows that you drew' do
		allow(Computer::WEAPONS).to receive(:sample).and_return("Paper")
		sign_in_and_play
		click_button 'Paper'
		expect(page).to have_text('You drew')
	end

end