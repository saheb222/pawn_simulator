
puts 'Welcome to Pawn Simulator'
puts 'Helpful commands ----- '
puts 'PLACE x,y,f,c ===> PLACE 0,0,NORTH,WHITE'
puts 'MOVE 2 ==> applicable for very first move'
puts 'MOVE 1 ===> applicable for very first move'
puts 'MOVE ===> applicable for subsequent moves'
puts 'LEFT, RIGHT ===> to change the Pawn direction'
puts 'REPORT ===> to see the pawn status'

puts '=========================================================================='

require './lib/command_handler.rb'
CommandHandler.start

