require 'sinatra/base'
require './lib/player'
require './lib/game'
require './lib/hand'

class RPS < Sinatra::Base

  enable :sessions

  get '/' do
    erb :signup
  end

  post '/names' do
  	player_1 = Player.new(params[:player_1])
  	session[:me] = player_1
  	#player_2 = Player.new("The Computer")
  	if ObjectSpace.each_object(Game).to_a.empty?
  		Game.create(session[:me])
  		redirect '/wait'
  	else
  		Game.instance.add_player(session[:me])
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
  	erb :rockpaperscissors
  end

  post '/fight' do
	my_weapon = params[:choice]
	Hand.hand(my_weapon, Game.instance.player_1)
 	Hand.instance.weapon
	redirect '/fight'
  end

  get '/fight' do
  	erb :fight
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
