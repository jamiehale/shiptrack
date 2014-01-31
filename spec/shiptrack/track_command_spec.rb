require 'spec_helper.rb'

module ShipTrack
  
  describe TrackCommand do
    
    describe '.initialize' do
      
      let( :command ) { TrackCommand.new }
    
      it 'has a name' do
        expect( command.name ).to eq 'track'
      end
    
      it 'has a description' do
        expect( command.description ).to_not be_nil
      end
    
      it 'handles the parameter set [index,int]' do
        expect( command.parameter_sets ).to include [ CommandParameter.new( :index, :int ) ]
      end
    
      it 'only handles 1 parameter set' do
        expect( command.parameter_sets.size ).to eq 1
      end
    
      it 'handles no options' do
        expect( command.options ).to be_empty
      end
      
    end
    
    describe '#run' do
      
      let( :command ) { TrackCommand.new }
      let( :params ) { { :index => 1 } }
      let( :configuration ) { { :active_shipments_filepath => 'some/path' } }
      let( :shipment_list ) { double( 'shipment_list' ) }
      let( :shipment ) { double( 'shipment' ) }
      
      before( :each ) do
        ShipmentList.stub( :load ).and_return( shipment_list )
        shipment_list.stub( :get_by_index ).and_return( shipment )
        shipment.stub( :ship_method ).and_return( 'UPS' )
        shipment.stub( :ship_tracking_number )
        Launchy.stub( :open )
      end
      
      it 'loads the active shipment list' do
        ShipmentList.should_receive( :load ).with( 'some/path' )
        command.run( params, configuration, {} )
      end
      
      it 'should defer to Launchy to show web page' do
        Launchy.should_receive( :open )
        command.run( params, configuration, {} )
      end
      
    end
    
  end
  
end
