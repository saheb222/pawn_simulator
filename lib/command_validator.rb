module CommandValidator
  DIRECTIONS_LIST = %w[EAST WEST NORTH SOUTH]
  COLORS = %w[BLACK WHITE]
  FIRST_MOLVE_ALLOWED_PLACES = %w[1 2]

  def validate_command(main_command, arg_array)
    case main_command
    when 'PLACE'
      validate_place_args(arg_array)
    when 'MOVE'
      validate_move_args(arg_array)
    when 'LEFT', 'RIGHT', 'REPORT'
      arg_array.empty?
    else
      false
    end
  end


  def validate_place_args(args_arr)
    return false unless args_arr.count.eql?(4)

    return false unless DIRECTIONS_LIST.include?(args_arr[2])

    return false unless COLORS.include?(args_arr[3])

    true
  rescue StandardError => e
    false
  end

  def validate_move_args(args_arr)
    return false if args_arr.count > 1

    true
  end

end
