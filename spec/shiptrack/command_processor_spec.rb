require 'spec_helper.rb'

module ShipTrack
  
  describe CommandProcessor do
    
    let( :command_processor ) { CommandProcessor.new }
    
    it 'starts with no commands' do
      expect( command_processor.commands ).to be_empty
    end
    
    describe 'after adding a command' do
      
      let( :command ) { double( 'command' ) }
      
      before( :each ) do
        command.stub( :name ).and_return( 'ship' )
        command.stub( :command_processor= )
        command_processor.handle( command )
      end
      
      it 'handles the command' do
        expect( command_processor.handles?( 'ship' ) ).to be_true
      end
      
      it 'retrieves the command' do
        expect( command_processor[ 'ship' ] ).to eq command
      end
      
      describe 'running a command' do
        
        let( :configuration ) { double( 'configuration' ) }
        let( :args ) { {} }
        let( :params ) { {} }
        let( :options ) { {} }
        
        before( :each ) do
          command.stub( :parse_options ).and_return( [ params, options ] )
          command.stub( :run )
        end
        
        it 'parses the options' do
          command.should_receive( :parse_options ).with( args )
          command_processor.run( 'ship', configuration, args )
        end
        
        it 'defers to the command to run' do
          command.should_receive( :run ).with( params, configuration, options )
          command_processor.run( 'ship', configuration, args )
        end
        
      end
      
    end
    
    describe 'multiple commands' do
      
      let( :command_1 ) { double( 'command_1' ) }
      let( :command_2 ) { double( 'command_2' ) }

      describe 'pre-sorted' do
        
        before( :each ) do
          command_1.stub( :command_processor= )
          command_1.stub( :name ).and_return( 'a' )
          command_2.stub( :command_processor= )
          command_2.stub( :name ).and_return( 'b' )
          command_processor.handle( command_1 )
          command_processor.handle( command_2 )
        end
      
        it 'iterates in order' do
          expect{ |b| command_processor.each_command( &b ) }.to yield_successive_args( command_1, command_2 )
        end
        
      end
      
      describe 'unsorted' do
        
        before( :each ) do
          command_1.stub( :command_processor= )
          command_1.stub( :name ).and_return( 'a' )
          command_2.stub( :command_processor= )
          command_2.stub( :name ).and_return( 'b' )
          command_processor.handle( command_2 )
          command_processor.handle( command_1 )
        end
      
        it 'iterates in order' do
          expect{ |b| command_processor.each_command( &b ) }.to yield_successive_args( command_1, command_2 )
        end
        
      end
      
    end
    
  end
  
end
