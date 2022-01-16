class Pawn
  attr_reader :x_coord, :y_coord, :direction, :color, :on_boarded
  attr_accessor :first_move

  def change_direction
  end

  def initialize()
    first_move = true
  end

  def report
    puts("#{x_coord}, #{y_coord}, #{direction}, #{color}")
  end
end