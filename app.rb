require 'sinatra/base'
require './lib/player'
require './lib/game'
require './lib/hand'
require './lib/a_round'

class RPS < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    erb :signup
  end

  post '/names' do
  	player = Player.new(params[:player1]) 
  	if ObjectSpace.each_object(Game).to_a.empty?
  		Game.create(player)
		session[:me] = Game.instance.player_1
  		redirect '/wait'
  	elsif Game.instance.player_1 == session[:me]
  		redirect '/wait'
  	else
  		Game.instance.add_player(player)
  		session[:me] = Game.instance.player_2
  		redirect '/RPS'
  	end
  end

  get '/wait' do
  	@player = session[:me]
  	erb :waiting_room
  end

  post '/waiting_room' do
  	if Game.instance.player_2 == nil
  		redirect '/wait'
  	else
 		redirect '/RPS' 		
    end
  end

  get '/RPS' do
  	@player = session[:me]
  	erb :rockpaperscissors
  end

  post '/fight' do
  	if !session[:me].my_hand && Game.instance.hands.empty?
	  	session[:me].assign_hand(params[:choice])
	  	Game.instance.hand_chosen(session[:me])
	  	p "or stuck here"
	  	redirect '/waiting_to_fight'
	elsif !session[:me].my_hand && Game.instance.hands[0].name != session[:me].name
		session[:me].assign_hand(params[:choice])
	  	Game.instance.hand_chosen(session[:me])
	  	redirect '/fight'
	elsif !!session[:me].my_hand && Game.instance.hands.length ==2	
		redirect '/fight'
	else !!session[:me].my_hand && Game.instance.hands[0].name == session[:me].name
		p "stuck here"
		p session[:me]
		p Game.instance.hands
		redirect '/waiting_to_fight'
	end
  end

  get '/waiting_to_fight' do
  	@player = session[:me]
  	erb :waiting_to_fight
  end

  get '/fight' do
  	p session[:me]
  	p Game.instance.player_2
  	Game.instance.find_winner(Game.instance.hands[0], Game.instance.hands[1])
  	@winner = Game.instance.winner
  	@my_hand = session[:me].my_hand
  	p Game.instance.hands 	
  	@my_opponents_hand = Game.instance.opponents_hand(session[:me]).my_hand
  	p Game.instance.hands
  	p @my_opponents_hand
  	erb :fight
  	
  end

  post '/reset' do
  	if Game.instance.hands.length == 2
  		session[:me].assign_hand(nil)
  		Game.instance.hands.delete_if {|value| value.name == session[:me].name }
  		redirect 'reset'
  	elsif Game.instance.hands.length == 1 && session[:me].my_hand == nil
  		redirect 'reset'
  	else
  		session[:me].assign_hand(nil)
  		Game.instance.hands.delete_if {|value| value.name == session[:me].name }
  		redirect '/RPS'
  	end 
  end

  get '/reset' do
  	@player = session[:me]
  	erb :waiting_room_round
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
