require_relative '../externals/externals.rb'
class Board
  X_MAX = 8.freeze
  Y_MAX = 8.freeze
  DIRECTION_MAP = {}.freeze
  PAWN_RECORD = {}.freeze

  def place_pawn(pawn, x_axs = 0, y_axs = 0)
    raise StandardError.new('invalid pawn') unless valid_pawn?(pawn)

    raise StandardError.new('coordinates must be positive') if negative_coorinates?(x_axs, y_axs)

    raise StandardError.new('Fall prevented!!!, wrong co-cordinates') if  coordinates_outside_board?(x_axs, y_axs)
    
    pawn.set_coordinates!(x_axs, y_axs) # Set the initial position of the Pawn
    pawn.mark_as_placed # Mark the pawn as it has been placed on board
  rescue StandardError => e
    puts e.message
  end

  def move_pawn(pawn, places = nil)
    raise StandardError.new('invalid pawn') unless valid_pawn?(pawn)

    raise StandardError.new('Pawn not found on board, please place the pawn on board') unless pawn.on_boarded

    raise StandardError.new('invalid move') unless is_a_valid_move?(pawn.first_move, places)

    x_axs, y_axs = get_new_x_y(pawn, places)

    raise StandardError.new('Fall Prevented!!!, wrong co-cordinates') if wrong_coordinates?(x_axs, y_axs)

    pawn.set_coordinates!(x_axs, y_axs)
    pawn.first_move = false if pawn.first_move
  rescue StandardError => e
    puts e.message
  end

  private

  def coordinates_outside_board?(x_axs, y_axs)
    x_axs >= X_MAX || y_axs >=Y_MAX 
  end

  def negative_coorinates?(x_axs, y_axs)
    x_axs.negative? || y_axs.negative?
  end
  
  def valid_pawn?(pawn)
    pawn.class.eql?(Pawn) && pawn.valid?
  end

  def get_new_x_y(pawn, places)
    places ||= 1
    x_axs = pawn.x_coord
    y_axs = pawn.y_coord
    case pawn.direction
    when 'EAST'
      x_axs += places
    when 'WEST'
      x_axs -= places
    when 'NORTH'
      y_axs += places
    when 'SOUTH'
      y_axs -= places
    end
    [x_axs, y_axs]
  end

  def is_a_valid_move?(first_move_status, places)
    return true if first_move_status && [1, 2].include?(places)
    
    return true if !first_move_status && places.nil?

    false
  end

  def wrong_coordinates?(x_axs, y_axs)
    negative_coorinates?(x_axs, y_axs) || coordinates_outside_board?(x_axs, y_axs)
  end
end