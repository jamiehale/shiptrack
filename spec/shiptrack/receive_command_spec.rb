require 'spec_helper.rb'

module ShipTrack
  
  describe ReceiveCommand do
    
    describe '.initialize' do
      
      let( :command ) { ReceiveCommand.new }
    
      it 'has a name' do
        expect( command.name ).to eq 'receive'
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
      
      it 'only handles 1 option' do
        expect( command.options.size ).to eq 1
      end
      
    end
    
    describe '#run' do
      
      let( :command ) { ReceiveCommand.new }
      let( :params ) { { :index => 1 } }
      let( :configuration ) { { :active_shipments_filepath => 'some/path' } }
      let( :shipment_list ) { double( 'shipment_list' ) }
      let( :shipment ) { double( 'shipment' ) }
      
      before( :each ) do
        ShipmentList.stub( :load ).and_return( shipment_list )
        shipment_list.stub( :get_by_index ).and_return( shipment )
        shipment_list.stub( :save )
        shipment.stub( :receive_date= )
      end
      
      it 'loads the active shipment list' do
        ShipmentList.should_receive( :load ).with( 'some/path' )
        command.run( params, configuration, {} )
      end
      
      it 'sets the receipt date on the shipment' do
        shipment.should_receive( :receive_date= ).with( DateTime.now.strftime( '%Y-%m-%d' ) )
        command.run( params, configuration, {} )
      end
      
      it 'sets the receipt date from an option' do
        shipment.should_receive( :receive_date= ).with( '2000-01-01' )
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
      
    end
    
  end
  
end