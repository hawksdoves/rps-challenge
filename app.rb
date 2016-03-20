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
  	if ObjectSpace.each_object(Game).to_a.empty?
  		Player.define(params[:player1]) 
  		Game.create(Player.instance)
		session[:me] = Game.instance.player_1
  		redirect '/wait'
  	elsif Game.instance.player_1 == session[:me]
  		redirect '/wait'
  	else
  		Player.define(params[:player1]) 
  		Game.instance.add_player(Player.instance)
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
  	if (!session[:me].my_hand && Round.instance == nil) || Round.instance.hands.empty?	
	  	session[:me].assign_hand(params[:choice])
	  	Round.instance.hand_chosen(session[:me])
	  	p "or stuck here"
	  	redirect '/waiting_to_fight'
	elsif !session[:me].my_hand && Round.instance.hands[0].name != session[:me].name
		session[:me].assign_hand(params[:choice])
	  	Round.instance.hand_chosen(session[:me])
	  	redirect '/fight'
	elsif !!session[:me].my_hand && Round.instance.hands.length ==2	
		redirect '/fight'
	else !!session[:me].my_hand && Round.instance.hands[0].name == session[:me].name
		p "stuck here"
		p session[:me]
		p Round.instance.hands
		p Round.instance
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
  	Game.instance.find_winner(Round.instance.hands[0], Round.instance.hands[1])
  	@winner = Game.instance.winner
  	@my_hand = session[:me].my_hand
  	@my_opponents_hand = Round.instance.opponents_hand(session[:me]).my_hand
  	p Round.instance.hands
  	p @my_opponents_hand
  	erb :fight
  	
  end

  post '/reset' do
  	if Round.instance.hands.length == 2
  		session[:me].assign_hand(nil)
  		Round.instance.hands.delete_if {|person| person.name == session[:me].name }
  		p "break here"
  		redirect 'reset'
  	elsif !Round.instance.hands.empty? && session[:me].my_hand == nil
  		p "or break here"
  		p Round.instance
  		redirect 'reset'
  	else
  		session[:me].assign_hand(nil)
  		Round.instance.hands.delete_if {|value| value.name == session[:me].name }
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
