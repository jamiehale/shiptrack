require 'spec_helper.rb'

module ShipTrack
  
  describe VersionCommand do
    
    describe '.initialize' do
      
      let( :command ) { VersionCommand.new }
    
      it 'has a name' do
        expect( command.name ).to eq 'version'
      end
    
      it 'has a description' do
        expect( command.description ).to_not be_nil
      end
    
      it 'handles the empty parameter set' do
        expect( command.parameter_sets ).to include []
      end
    
      it 'only handles 1 parameter set' do
        expect( command.parameter_sets.size ).to eq 1
      end
    
      it 'handles no options' do
        expect( command.options ).to be_empty
      end
      
    end
    
    describe '#run' do
      
      let( :command ) { VersionCommand.new }
      
      it 'dumps the version' do
        $stdout.stub( :puts )
        $stdout.should_receive( :puts )
        command.run( {}, nil, {} )
      end
      
    end
    
  end
  
end
