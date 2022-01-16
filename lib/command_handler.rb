require_relative 'pawn'
require_relative '../externals/externals'
require_relative 'command_validator'

class CommandHandler
  extend CommandValidator

  attr_accessor :command
  attr_reader :executable, :args
  def initialize(command)
    splitted_command = command.split(' ')
    @executable = splitted_command.first
    @args = splitted_command[1..-1]&.join(' ')&.split(',')&.map(&:strip)
  end

  def is_valid?
    self.class.validate_command(@executable, @args)
  end

  class << self
    def start
      pawn = Pawn.new()
      command = get_user_command(pawn)
      while !command.executable.eql?('q')
        command = get_user_command(pawn) # Getting Next command
      end
    end

    def get_user_command(pawn)
      if !pawn.on_boarded
        puts 'Please Enter the PLACE command'
      else
        puts 'Please enter another command'
      end
      new gets().chop.upcase
    end
  end

  private

end