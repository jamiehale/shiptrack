# This file is part of ShipTrack.
#
# Copyright 2014 Jamie Hale <jamie@smallarmyofnerds.com>
#
# ShipTrack is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# ShipTrack is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with ShipTrack. If not, see <http://www.gnu.org/licenses/>.

require 'spec_helper.rb'

module ShipTrack
  
  describe ShipCommand do
    
    let( :command ) { ShipCommand.new }

    describe '.initialize' do
      
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
        expect( command.options ).to include CommandOption.new( :date, :string, 'Specify the date on which the shipment was shipped' )
      end
      
      it 'handles a method option' do
        expect( command.options ).to include CommandOption.new( :method, :string, 'Specify the method used to ship' )
      end
      
      it 'handles a tracking_number option' do
        expect( command.options ).to include CommandOption.new( :tracking_number, :string, 'Specify the shipping tracking number' )
      end
      
      it 'only handles 3 options' do
        expect( command.options.size ).to eq 3
      end
      
    end
    
    describe '#run' do
      
      let( :params ) { { :index => 1 } }
      let( :configuration ) { { :active_shipments_filepath => 'some/path' } }
      let( :shipment_list ) { double( 'shipment_list' ) }
      let( :shipment ) { build( :paid_shipment ) }
      
      before( :each ) do
        ShipmentList.stub( :load ).and_return( shipment_list )
        shipment_list.stub( :get_by_index ).and_return( shipment )
        shipment_list.stub( :save )
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
        shipment.stub( :tracking_number= )
        shipment.should_receive( :tracking_number= ).with( '12345' )
        command.run( params, configuration, { :tracking_number => '12345' } )
      end
      
    end
    
    describe '#run on shipment with invalid state' do

      let( :params ) { { :index => 1 } }
      let( :configuration ) { { :active_shipments_filepath => 'some/path' } }
      let( :shipment_list ) { double( 'shipment list' ) }
      
      before( :each ) do
        ShipmentList.stub( :load ).and_return( shipment_list )
        shipment_list.stub( :save )
      end

      describe 'shipped' do
        
        before( :each ) do
          shipment_list.stub( :get_by_index ).and_return( build( :shipped_shipment ) )
        end
        
        it 'fails if the shipment has already shipped' do
          expect { command.run( params, configuration, {} ) }.to raise_error 'Shipment already shipped'
        end
        
      end
      
      describe 'received' do
        
        before( :each ) do
          shipment_list.stub( :get_by_index ).and_return( build( :received_shipment ) )
        end
        
        it 'fails if the shipment has already been received' do
          expect { command.run( params, configuration, {} ) }.to raise_error 'Shipment already received'
        end
        
      end
      
    end
    
  end
  
end
