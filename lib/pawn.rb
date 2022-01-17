require_relative '../externals/externals.rb'
class Pawn
  attr_reader :x_coord, :y_coord, :direction, :color, :on_boarded
  attr_accessor :first_move
  VALID_SIDES = %w[EAST WEST NORTH SOUTH]
  VALID_DIRECTIONS = %w[LEFT RIGHT]
  DIRECTION_MAP = {
    LEFT: { 'EAST' => 'NORTH', 'WEST' => 'SOUTH', 'NORTH'=> 'WEST', 'SOUTH' => 'EAST' },
    RIGHT: { 'EAST' => 'SOUTH', 'WEST' => 'NORTH', 'NORTH'=> 'EAST', 'SOUTH' => 'WEST' }
  }
  def initialize
    @first_move = true
  end

  def turn(direction)
    return unless VALID_DIRECTIONS.include?(direction)

    @direction = DIRECTION_MAP.dig(direction.to_sym, self.direction)
    self
  end

  def set_color!(color)
    @color = color
    self
  end
  
  def set_direction!(side)
    return unless VALID_SIDES.include?(side)

    @direction = side
  end

  def set_coordinates!(x_axs, y_axs)
    @x_coord = x_axs
    @y_coord = y_axs
    self
  end

  def report
    puts "#{x_coord}, #{y_coord}, #{direction}, #{color}"
  end
  
  def mark_as_placed
    @on_boarded = true if already_placed?
  end
  
  def valid?
    !(color.nil? && direction.nil?)
  end

  def already_placed?
    !(x_coord.nil? || y_coord.nil?)
  end
end