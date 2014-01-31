require 'spec_helper.rb'

module ShipTrack
  
  describe ShipCommand do
    
    describe '.initialize' do
      
      let( :command ) { ShipCommand.new }
    
      it 'has a name' do
        expect( command.name ).to eq 'ship'
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
    
      it 'handles a date option' do
        expect( command.options ).to include CommandOption.new( :date, :string )
      end
      
      it 'handles a method option' do
        expect( command.options ).to include CommandOption.new( :method, :string )
      end
      
      it 'handles a tracking_number option' do
        expect( command.options ).to include CommandOption.new( :tracking_number, :string )
      end
      
      it 'only handles 3 options' do
        expect( command.options.size ).to eq 3
      end
      
    end
    
    describe '#run' do
      
      let( :command ) { ShipCommand.new }
      let( :params ) { { :index => 1 } }
      let( :configuration ) { { :active_shipments_filepath => 'some/path' } }
      let( :shipment_list ) { double( 'shipment_list' ) }
      let( :shipment ) { double( 'shipment' ) }
      
      before( :each ) do
        ShipmentList.stub( :load ).and_return( shipment_list )
        shipment_list.stub( :get_by_index ).and_return( shipment )
        shipment_list.stub( :save )
        shipment.stub( :ship_date= )
      end
      
      it 'loads the active shipment list' do
        ShipmentList.should_receive( :load ).with( 'some/path' )
        command.run( params, configuration, {} )
      end
      
      it 'sets the ship date on the shipment' do
        shipment.should_receive( :ship_date= ).with( DateTime.now.strftime( '%Y-%m-%d' ) )
        command.run( params, configuration, {} )
      end
      
      it 'sets the ship date from an option' do
        shipment.should_receive( :ship_date= ).with( '2000-01-01' )
        command.run( params, configuration, { :date => '2000-01-01' } )
      end
      
      it 'saves the shipment list' do
        shipment_list.should_receive( :save ).with( 'some/path' )
        command.run( params, configuration, {} )
      end

      it 'fails if the index is invalid' do
        shipment_list.stub( :get_by_index ).and_raise 'Invalid index'
        expect { command.run( params, configuration, {} ) }.to raise_error 'Invalid index'
      end
      
      it 'sets a ship method if provided' do
        shipment.stub( :ship_method= )
        shipment.should_receive( :ship_method= ).with( 'UPS' )
        command.run( params, configuration, { :method => 'UPS' } )
      end
      
      it 'sets a tracking number if provided' do
        shipment.stub( :ship_tracking_number= )
        shipment.should_receive( :ship_tracking_number= ).with( '12345' )
        command.run( params, configuration, { :tracking_number => '12345' } )
      end
      
    end
    
  end
  
end