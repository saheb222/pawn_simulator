class Pawn
  attr_reader :x_coord, :y_coord, :direction, :color, :on_boarded
  attr_accessor :first_move

  def initialize()
    first_move = true
  end
end