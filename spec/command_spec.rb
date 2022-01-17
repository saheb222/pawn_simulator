
describe 'Command' do
  context 'perform valid commands' do
    
    before(:each) do
      @pawn = Pawn.new
      @board = Board.new
      @commander = CommandHandler.new('PLACE 1,1,NORTH,WHITE')
      @commander.pawn = @pawn
      @commander.board = @board
    end

    it 'performs valid PLACE Command' do
      expect(@commander.is_valid_command?).to be_truthy
      @commander.execute
      expect(@pawn.on_boarded).to be_truthy
      expect { @pawn.report }.to output("1, 1, NORTH, WHITE\n").to_stdout
      expect(@pawn.first_move).to be_truthy
    end

    it 'performs valid first move command' do
      @commander.execute
      @commander.set_command!('MOVE 2').execute
      expect { @pawn.report }.to output("1, 3, NORTH, WHITE\n").to_stdout
      @commander.set_command!('MOVE').execute
      expect { @pawn.report }.to output("1, 4, NORTH, WHITE\n").to_stdout
    end

    it 'performs valid turn command' do
      @commander.execute
      @commander.set_command!('RIGHT').execute
      expect(@pawn.direction).to eq('EAST')
      @commander.set_command!('RIGHT').execute
      expect(@pawn.direction).to eq('SOUTH')
    end
  end
  
  context 'perform invalid commands' do
    before(:each) do
      @pawn = Pawn.new
      @board = Board.new
      @commander = CommandHandler.new('PLACE 1,1,NORTH,WHITE')
      @commander.pawn = @pawn
      @commander.board = @board
    end

    it 'shows error for invalid place command' do
      @commander.set_command!('PLACE 10,10,NORTH,WHITE')
      expect { @commander.execute }.to output("Fall prevented!!!, wrong co-cordinates\n").to_stdout
      @commander.set_command!('PLACE -10,10,NORTH,WHITE')
      expect { @commander.execute }.to output("coordinates must be positive\n").to_stdout
    end

    it 'shows error for invalid move commands' do
      @commander.execute
      @commander.set_command!('MOVE')
      expect { @commander.execute }.to output("invalid first move command, valid : MOVE 1 | MOVE 2\n").to_stdout
      @commander.set_command!('MOVE 1').execute
      expect { @commander.set_command!('REPORT').execute }.to output("1, 2, NORTH, WHITE\n").to_stdout
      @commander.set_command!('MOVE 1')
      expect { @commander.execute }.to output("invalid subsequent move command, pleace use 'MOVE' without args. ('MOVE 1' and 'MOVE 2' are for first move)\n").to_stdout
    end

    it 'shows error if we run REPORT/LEFT/RIGHT/MOVE command before PLACE Command' do
      error_message = 'Command not permissible!!! Please place the Pawn on board first'
      expect { @commander.set_command!('MOVE').execute }.to output("#{error_message}\n").to_stdout
      expect { @commander.set_command!('LEFT').execute }.to output("#{error_message}\n").to_stdout
      expect { @commander.set_command!('RIGHT').execute }.to output("#{error_message}\n").to_stdout
      expect { @commander.set_command!('REPORT').execute }.to output("#{error_message}\n").to_stdout
    end
  end

  context 'perform few tests' do
    before(:each) do
      @pawn = Pawn.new
      @board = Board.new
      @commander = CommandHandler.new('PLACE 1,1,NORTH,WHITE')
      @commander.pawn = @pawn
      @commander.board = @board
    end

    it 'performs testcase : 1' do
      ['PLACE 0,0,NORTH,WHITE', 'MOVE 1', 'REPORT'].each do |command|
        @commander.set_command!(command).execute
      end
      expect { @commander.execute }.to output("0, 1, NORTH, WHITE\n").to_stdout
    end

    it 'performs testcase : 2' do
      ['PLACE 0,0,NORTH,BLACK', 'LEFT', 'REPORT'].each do |command|
        @commander.set_command!(command).execute
      end
      expect { @commander.execute }.to output("0, 0, WEST, BLACK\n").to_stdout
    end

    it 'performs testcase : 3' do
      ['PLACE 1,2,EAST,BLACK', 'MOVE 2', 'MOVE 1', 'LEFT', 'MOVE', 'REPORT'].each do |command|
        @commander.set_command!(command).execute
      end
      expect { @commander.execute }.to output("3, 3, NORTH, BLACK\n").to_stdout
    end
  end
end