describe Pawn do
  it 'returns first move as true' do
    pawn = Pawn.new
    expect(pawn.first_move).to be_truthy
  end

  it 'sets the direction' do
    pawn = Pawn.new
    pawn.set_direction! 'EAST'
    expect(pawn.direction).to eq('EAST')
    pawn.set_direction!('NORTHEAST')
    expect(pawn.direction).to eq('EAST') # unchanged direction
  end

  it 'checks whether the pawn is placed or not' do
    pawn = Pawn.new
    expect(pawn.already_placed?).to be_falsey

  end

  it 'turns the pawn left/right' do
    pawn = Pawn.new
    pawn.set_direction! 'WEST'
    pawn.turn 'LEFT'
    expect(pawn.direction).to eq('SOUTH')
    pawn.turn 'LEFT'
    expect(pawn.direction).to eq('EAST')
  end

  it 'checks whether the pwn is on board' do
    pawn = Pawn.new
    expect(pawn.on_boarded).to be_falsey
  end
end