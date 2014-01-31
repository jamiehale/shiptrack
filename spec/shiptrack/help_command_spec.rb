require 'spec_helper.rb'

module ShipTrack
  
  describe HelpCommand do
    
    describe '.initialize' do
      
      let( :command ) { HelpCommand.new }
    
      it 'has a name' do
        expect( command.name ).to eq 'help'
      end
    
      it 'has a description' do
        expect( command.description ).to_not be_nil
      end
    
      it 'handles the parameter set [command,string]' do
        expect( command.parameter_sets ).to include [ CommandParameter.new( :command, :string ) ]
      end
    
      it 'only handles 1 parameter set' do
        expect( command.parameter_sets.size ).to eq 1
      end
    
      it 'handles no options' do
        expect( command.options ).to be_empty
      end
      
    end
    
    describe '#run' do
      
      let( :command ) { HelpCommand.new }
      let( :command_processor ) { double( 'command_processor' ) }
      let( :help_command ) { double( 'help_command' ) }
      let( :params ) { { :command => 'ship' } }
      
      before( :each ) do
        command.command_processor = command_processor
        command_processor.stub( :handles? ).and_return( true )
        command_processor.stub( :[] ).and_return( help_command )
        help_command.stub( :usage )
      end
      
      it 'finds the correct command' do
        command_processor.should_receive( :[] ).with( 'ship' )
        command.run( params, nil, {} )
      end
      
      it 'defers usage info to the command' do
        help_command.should_receive( :usage )
        command.run( params, nil, {} )
      end
      
      it 'fails if the command cannot be found' do
        command_processor.stub( :handles? ).and_return( false )
        expect { command.run( params, nil, {} ) }.to raise_error 'No such command \'ship\''
      end
      
    end
    
  end
  
end
