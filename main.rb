
puts 'Welcome to Pawn Simulator'
puts 'Helpful commands ----- '
puts 'PLACE x,y,f,c ===> PLACE 0,0,NORTH,WHITE'
puts 'MOVE 2 ==> applicable for very first move'
puts 'MOVE 1 ===> applicable for very first move'
puts 'MOVE ===> applicable for subsequent moves'
puts 'LEFT, RIGHT ===> to change the Pawn direction'
puts 'REPORT ===> to see the pawn status'

puts '=========================================================================='

# pawn = Pawn.new #blank pawn object

# require './lib/pawn.rb'
# require './lib/simulator.rb'
# require './lib/'
require './lib/command_handler.rb'
CommandHandler.start

# while valid_command?
# 	case command
# 	when place
# 		pawn.place
# 	when move
# 		pawn.move()
# 	when left, right
# 	when report
# 	else
# 		puts 'invalid command'
# 	end
# 	command = gets() # Take other commands
# end
