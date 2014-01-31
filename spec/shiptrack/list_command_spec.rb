require 'spec_helper.rb'

module ShipTrack
  
  describe ListCommand do
    
    describe '.initialize' do
      
      let( :command ) { ListCommand.new }
    
      it 'has a name' do
        expect( command.name ).to eq 'list'
      end
    
      it 'has a description' do
        expect( command.description ).to_not be_nil
      end
    
      it 'handles empty parameter set' do
        expect( command.parameter_sets ).to include []
      end
    
      it 'only handles 1 parameter set' do
        expect( command.parameter_sets.size ).to eq 1
      end
    
      it 'handles a ordered option' do
        expect( command.options ).to include CommandOption.new( :ordered, :flag )
      end
      
      it 'handles a paid option' do
        expect( command.options ).to include CommandOption.new( :paid, :flag )
      end
      
      it 'handles a shipped option' do
        expect( command.options ).to include CommandOption.new( :shipped, :flag )
      end
      
      it 'handles a received option' do
        expect( command.options ).to include CommandOption.new( :received, :flag )
      end
      
      it 'only handles 4 options' do
        expect( command.options.size ).to eq 4
      end
      
    end
    
    describe '#run' do
      
      let( :command ) { ListCommand.new }
      let( :params ) { {} }
      let( :configuration ) { { :active_shipments_filepath => 'some/path' } }
      let( :shipment_list ) { double( 'shipment_list' ) }
      let( :shipment ) { double( 'shipment' ) }
      
      before( :each ) do
        ShipmentList.stub( :load ).and_return( shipment_list )
        shipment_list.stub( :each ).and_yield( 0, shipment )
        shipment.stub( :name )
        shipment.stub( :state )
        $stdout.stub( :puts )
      end
      
      it 'loads the active shipment list' do
        ShipmentList.should_receive( :load ).with( 'some/path' )
        command.run( params, configuration, {} )
      end
      
    end
    
  end
  
end
