require_relative 'a_round'

p1 = Player.new("Bob")
p2 = Player.new("Ann")

Game.create(p1)
Game.instance.add_player(p2)
p Game.instance
puts
Round.lets_play
h1 = Hand.hand("Rock", p1)
Round.instance.hand_chosen(h1)
p Round.instance.hands
puts
h2 = Hand.hand("Paper", p2)
Round.instance.hand_chosen(h2)
p Round.instance.hands
puts
p Game.instance.find_winner(h1,h2)