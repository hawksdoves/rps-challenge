require 'sinatra/base'
require './lib/player'
require './lib/computer'
require './lib/weapon'

class RPS < Sinatra::Base

  enable :sessions

  get '/' do
    erb :signup
  end

  post '/names' do
  	session[:me] = params[:player_1]
  	redirect '/RPS'
  end

  get '/RPS' do
    @me = session[:me]
  	erb :rockpaperscissors
  end

  post '/fight' do
    player = Player.new(session[:me]) 
  	player.chooses(params[:choice])  
    @my_hand = player.weapon_choice.type
    computer = Computer.new
    computer.weapon
    @opponents_hand = computer.weapon_choice
    results = player.fights(computer)
    erb results
  end



  # start the server if ruby file executed directly
  run! if app_file == $0
end
