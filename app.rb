require 'sinatra/base'
require './lib/player'
require './lib/game'
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
  		Round.lets_play	  	
  		session[:my_round] = Round.instance
	  	session[:me].assign_hand(params[:choice])
	  	session[:my_round].hand_chosen(session[:me])
	  	redirect '/waiting_to_fight'
	elsif !session[:me].my_hand && !!Round.instance
		session[:my_round] = Round.instance
		session[:me].assign_hand(params[:choice])
	  	session[:my_round].hand_chosen(session[:me])
	  	redirect '/fight'
	elsif !!session[:me].my_hand && Round.instance.hands.length ==2	
		redirect '/fight'
	else 
		redirect '/waiting_to_fight'
	end
  end

  get '/waiting_to_fight' do
  	@player = session[:me]
  	erb :waiting_to_fight
  end

  get '/fight' do
  	Game.instance.find_winner(Round.instance.hands[0], Round.instance.hands[1])
  	@winner = Game.instance.winner
  	@my_hand = session[:me].my_hand
  	@my_opponents_hand = Round.instance.opponents_hand(session[:me]).my_hand
  	p session[:me]
  	p Game.instance.player_2
  	p Game.instance.player_1
  	p Round.instance.object_id 
  	p session[:my_round].hands
  	p @my_opponents_hand
  	p Round.instance.object_id 
  	p session[:my_round].object_id
  	erb :fight
  	
  end

  post '/reset' do
  	if Round.instance.hands.length == 2
  		session[:me].assign_hand(nil)
  		Round.instance.hands.delete_if {|person| person.name == session[:me].name }
  		old_round = Round.instance
  		redirect 'reset'
  	elsif Round.instance.hands.length ==1 && old_round.object_id == Round.instance.object_id && session[:me].my_hand == nil
  		p Round.instance  		
 
  		redirect '/reset'
  	else
  		session[:me].assign_hand(nil)
  		session[:my_round] = nil
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
