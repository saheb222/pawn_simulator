require_relative '../lib/board'

describe Board do
  it 'place pawn on board' do
    board = Board.new
    pawn = Pawn.new
    pawn.set_color! 'WHITE'
    pawn.set_direction! 'NORTH'
    board.place_pawn(pawn, 0, 0)

    expect(pawn.on_boarded).to be_truthy
  end

  it 'shows error due to invalid pawn' do
    board = Board.new
    pawn = Pawn.new
    expect { board.place_pawn(pawn, 0, 0) }.to output("invalid pawn\n").to_stdout
  end

  it 'shows error due to worng coordinates' do
    board = Board.new
    pawn = Pawn.new
    pawn.set_color! 'WHITE'
    pawn.set_direction! 'NORTH'
    expect { board.place_pawn(pawn, 9, 10) }.to output("Fall prevented!!!, wrong co-cordinates\n").to_stdout
    expect { board.place_pawn(pawn, -1, 5) }.to output("coordinates must be positive\n").to_stdout
    expect(pawn.on_boarded).to be_falsey
    expect(pawn.x_coord && pawn.x_coord).to be_falsey

  end

  it 'moves the pawn on board' do
    board = Board.new
    pawn = Pawn.new
    pawn.set_color! 'WHITE'
    pawn.set_direction! 'NORTH'
    board.place_pawn(pawn, 0, 0)
    board.move_pawn(pawn, 1)
    expect { pawn.report }.to output("0, 1, NORTH, WHITE\n").to_stdout
  end

  it 'prevents moving the pawn as the pawn is not on the board' do
    board = Board.new
    pawn = Pawn.new
    pawn.set_color! 'WHITE'
    pawn.set_direction! 'NORTH'
    expect { board.move_pawn(pawn, 1) }.to output("Pawn not found on board, please place the pawn on board\n").to_stdout
  end

  it 'prevents moving the pawn as the as the next move will result a falling' do
    board = Board.new
    pawn = Pawn.new
    pawn.set_color! 'WHITE'
    pawn.set_direction! 'NORTH'
    board.place_pawn(pawn, 7, 7)
    expect { board.move_pawn(pawn, 1) }.to output("Fall Prevented!!!, wrong co-cordinates\n").to_stdout
  end
end