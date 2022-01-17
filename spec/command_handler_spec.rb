require 'command_handler'

describe CommandHandler do
  it 'checks whether commands are getting classified' do
    command = CommandHandler.new('PLACE 1,1,NORTH,BLACK')
    expect(command.executable).to eq('PLACE')
    expect(command.args).to eq(['1','1','NORTH','BLACK'])
  end

  it 'validates wrong place command' do
    command1 = CommandHandler.new('PLAC 1,1,NORTH,BLACK')
    command2 = CommandHandler.new('PLAC 1,1,NORTH,BROWN')
    command3 = CommandHandler.new('PLACE 1,1,NORTH')
    command4 = CommandHandler.new('PLACE')
    command4 = CommandHandler.new('PLACE 1,1,BLACK,BLACK')
    c1_status = command1.is_valid_command?
    c2_status = command2.is_valid_command?
    c3_status = command3.is_valid_command?
    c4_status = command4.is_valid_command?
    expect(c1_status).to be_falsey
    expect(c2_status).to be_falsey
    expect(c3_status).to be_falsey
    expect(c4_status).to be_falsey
  end
  
  it 'validates correct place command' do
    command1 = CommandHandler.new('PLACE 1,1,NORTH,BLACK')
    command2 = CommandHandler.new('PLACE 3,5,WEST,WHITE')
    c1_status = command1.is_valid_command?
    c2_status = command2.is_valid_command?
    expect(c1_status).to be_truthy
    expect(c2_status).to be_truthy
  end

  it 'validates incorrect move command' do
    command1 = CommandHandler.new('MOVE 4,4')
    command2 = CommandHandler.new('MOVE d')
    command3 = CommandHandler.new('MOVE 50')
    c1_status = command1.is_valid_command?
    c2_status = command2.is_valid_command?
    c3_status = command3.is_valid_command?
    expect(c1_status).to be_falsey
    expect(c2_status).to be_falsey
    expect(c3_status).to be_falsey
  end

  it 'validates corrent move command' do
    command1 = CommandHandler.new('MOVE')
    command2 = CommandHandler.new('MOVE 1')
    c1_status = command1.is_valid_command?
    c2_status = command2.is_valid_command?
    expect(c1_status).to be_truthy
    expect(c2_status).to be_truthy
  end
  
  it 'validates LEFT RIGHT command' do
    # LEFT RIGHT command requires no combination so can be exluded from handler spec
  end
  
  it 'validates report command' do
    # report command requires no combination so can be excluded from handler spec
  end
end