require_relative 'pawn'
require_relative 'board'
require_relative '../externals/externals'
require_relative 'command_validator'

class CommandHandler
  extend CommandValidator

  attr_accessor :board, :pawn
  attr_reader :executable, :args

  def initialize(command)
    set_command!(command)
  end

  # Split the command into two parts
  # @executable contains main commands , eg: PLACE
  # @args contains the arguments of the command, eg: 1,1,NORTH,BLACK
  def set_command!(command)
    splitted_command = command.split(' ')
    @executable = splitted_command.first
    @args = splitted_command[1..-1]&.join(' ')&.split(',')&.map(&:strip)
    self
  end

  # this method checks if the command is valid or not
  def is_valid_command?
    self.class.validate_command(@executable, @args)
  end

  # this method act as command runner
  # Identify the main command and pefrom few checks before executing
  def execute
    return unless additional_check_passed?

    case @executable
    when 'PLACE'
      initiate_place_command
    when 'MOVE'
      initiate_move_command
    when 'LEFT', 'RIGHT'
      pawn.turn(executable)
    when 'REPORT'
      pawn.report
    else
      puts 'not a valid command'
    end
  rescue StandardError => e
    puts e.message
  end


  class << self
    def start(pawn, board)
      command_handler = new(get_user_command)
      command_handler.pawn = pawn
      command_handler.board = board
      while !command_handler.executable.eql?('Q')
        if command_handler.is_valid_command?
          command_handler.execute
        else
          puts 'invalid command'
        end
        command_handler.set_command!(get_user_command(command_handler.pawn&.on_boarded)) # Getting Next command
      end
    end

    def get_user_command(pawn_on_borded = false)
      if !pawn_on_borded
        puts 'Please Enter the PLACE command'
      else
        puts 'Please enter another command'
      end
      gets().chop.upcase
    end
  end

  private

  def initiate_place_command
    x_axs = args[0].to_i
    y_axs = args[1].to_i
    pawn.set_direction!(args[2])
    pawn.set_color!(args[3])
    board.place_pawn(pawn, x_axs, y_axs)
  end

  def initiate_move_command
    raise StandardError.new('invalid first move command, valid : MOVE 1 | MOVE 2') if pawn.first_move && args.first.nil?

    raise StandardError.new("invalid subsequent move command, pleace use 'MOVE' without args. ('MOVE 1' and 'MOVE 2' are for first move)") if !pawn.first_move && !args.first.nil?

    places = args.first.nil? ? nil : args.first.to_i
    board.move_pawn(pawn, places)
  rescue StandardError => e
    puts e.message
  end

  # This check is to validate if we already have performed a valid PLACE command
  # before REPORT/LEFT/RIGHT/MOVE command
  def additional_check_passed?
    return true if pawn.already_placed? || executable.eql?('PLACE')

    puts StandardError.new('Command not permissible!!! Please place the Pawn on board first')
    false
  end
end