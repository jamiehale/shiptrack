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
  
  describe UpdateCommand do
    
    describe '.initialize' do
      
      let( :command ) { UpdateCommand.new }
    
      it 'has a name' do
        expect( command.name ).to eq 'update'
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
    
      it 'handles a name option' do
        expect( command.options ).to include CommandOption.new( :name, :string )
      end
      
      it 'handles a name option' do
        expect( command.options ).to include CommandOption.new( :name, :string )
      end
      
      it 'handles a vendor option' do
        expect( command.options ).to include CommandOption.new( :vendor, :string )
      end
      
      it 'handles a order_date option' do
        expect( command.options ).to include CommandOption.new( :order_date, :string )
      end
      
      it 'handles a purchase_date option' do
        expect( command.options ).to include CommandOption.new( :purchase_date, :string )
      end
      
      it 'handles a ship_date option' do
        expect( command.options ).to include CommandOption.new( :ship_date, :string )
      end
      
      it 'handles a ship_method option' do
        expect( command.options ).to include CommandOption.new( :ship_method, :string )
      end
      
      it 'handles a tracking_number option' do
        expect( command.options ).to include CommandOption.new( :tracking_number, :string )
      end
      
      it 'handles a receive_date option' do
        expect( command.options ).to include CommandOption.new( :receive_date, :string )
      end
      
      it 'handles a clear_receipt option' do
        expect( command.options ).to include CommandOption.new( :clear_receipt, :flag )
      end
      
      it 'handles a clear_shipping option' do
        expect( command.options ).to include CommandOption.new( :clear_shipping, :flag )
      end
      
      it 'handles a clear_payment option' do
        expect( command.options ).to include CommandOption.new( :clear_payment, :flag )
      end
      
      it 'only handles 11 options' do
        expect( command.options.size ).to eq 11
      end
      
    end
    
    describe '#run' do
      
      let( :command ) { UpdateCommand.new }
      let( :params ) { { :index => 1 } }
      let( :configuration ) { { :active_shipments_filepath => 'some/path' } }
      let( :shipment_list ) { double( 'shipment_list' ) }
      let( :shipment ) { double( 'shipment' ) }
      
      before( :each ) do
        ShipmentList.stub( :load ).and_return( shipment_list )
        shipment_list.stub( :get_by_index ).and_return( shipment )
        shipment_list.stub( :save )
        shipment.stub( :name= )
        shipment.stub( :purchase_date= )
      end
      
      it 'loads the active shipment list' do
        ShipmentList.should_receive( :load ).with( 'some/path' )
        command.run( params, configuration, {} )
      end
      
      it 'saves the shipment list' do
        shipment_list.should_receive( :save ).with( 'some/path' )
        command.run( params, configuration, {} )
      end

      it 'fails if the index is invalid' do
        shipment_list.stub( :get_by_index ).and_raise 'Invalid index'
        expect { command.run( params, configuration, {} ) }.to raise_error 'Invalid index'
      end
      
      describe 'updating name' do
        
        let( :options ) { { :name => 'New Name' } }
        
        it 'sets the new name' do
          shipment.should_receive( :name= ).with( 'New Name' )
          command.run( params, configuration, options )
        end
        
      end
      
      describe 'updating vendor' do
        
        let( :options ) { { :vendor => 'New Vendor' } }
        
        it 'sets the new vendor' do
          shipment.should_receive( :vendor= ).with( 'New Vendor' )
          command.run( params, configuration, options )
        end
        
      end
      
      describe 'updating order date' do
        
        let( :options ) { { :order_date => '2013-01-01' } }
        
        it 'sets the new order date' do
          shipment.should_receive( :order_date= ).with( '2013-01-01' )
          command.run( params, configuration, options )
        end
        
      end
      
      describe 'updating purchase date' do
        
        let( :options ) { { :purchase_date => '2013-01-01' } }
        
        it 'sets the new purchase date' do
          shipment.should_receive( :purchase_date= ).with( '2013-01-01' )
          command.run( params, configuration, options )
        end
        
      end
      
      describe 'updating shipping date' do
        
        let( :options ) { { :ship_date => '2013-01-01' } }
        
        it 'sets the new ship date' do
          shipment.should_receive( :ship_date= ).with( '2013-01-01' )
          command.run( params, configuration, options )
        end
        
      end
      
      describe 'updating shipping method' do
        
        let( :options ) { { :ship_method => 'UPS' } }
        
        it 'sets the new ship method' do
          shipment.should_receive( :ship_method= ).with( 'UPS' )
          command.run( params, configuration, options )
        end
        
      end
      
      describe 'updating tracking number' do
        
        let( :options ) { { :tracking_number => '12345' } }
        
        it 'sets the new tracking number' do
          shipment.should_receive( :ship_tracking_number= ).with( '12345' )
          command.run( params, configuration, options )
        end
        
      end
      
      describe 'updating receipt date' do
        
        let( :options ) { { :receive_date => '2013-01-01' } }
        
        it 'sets the new receipt date' do
          shipment.should_receive( :receive_date= ).with( '2013-01-01' )
          command.run( params, configuration, options )
        end
        
      end
      
      describe 'clearing receipt' do
        
        let( :options ) { { :clear_receipt => true } }
        
        it 'clears the receipt date' do
          shipment.should_receive( :receive_date= ).with( nil )
          command.run( params, configuration, options )
        end
        
      end
      
      describe 'clearing shipping' do
        
        let( :options ) { { :clear_shipping => true } }
        
        before( :each ) do
          shipment.stub( :ship_date= )
          shipment.stub( :ship_method= )
          shipment.stub( :ship_tracking_number= )
          shipment.stub( :receive_date= )
        end
        
        it 'clears the ship date' do
          shipment.should_receive( :ship_date= ).with( nil )
          command.run( params, configuration, options )
        end
        
        it 'clears the ship method' do
          shipment.should_receive( :ship_method= ).with( nil )
          command.run( params, configuration, options )
        end
        
        it 'clears the tracking number' do
          shipment.should_receive( :ship_tracking_number= ).with( nil )
          command.run( params, configuration, options )
        end
        
        it 'clears the receipt date' do
          shipment.should_receive( :receive_date= ).with( nil )
          command.run( params, configuration, options )
        end
        
      end
      
      describe 'clearing payment' do
        
        let( :options ) { { :clear_payment => true } }
        
        before( :each ) do
          shipment.stub( :purchase_date= )
          shipment.stub( :ship_date= )
          shipment.stub( :ship_method= )
          shipment.stub( :ship_tracking_number= )
          shipment.stub( :receive_date= )
        end
        
        it 'clears the purchase date' do
          shipment.should_receive( :purchase_date= ).with( nil )
          command.run( params, configuration, options )
        end
        
        it 'clears the ship date' do
          shipment.should_receive( :ship_date= ).with( nil )
          command.run( params, configuration, options )
        end
        
        it 'clears the ship method' do
          shipment.should_receive( :ship_method= ).with( nil )
          command.run( params, configuration, options )
        end
        
        it 'clears the tracking number' do
          shipment.should_receive( :ship_tracking_number= ).with( nil )
          command.run( params, configuration, options )
        end
        
        it 'clears the receipt date' do
          shipment.should_receive( :receive_date= ).with( nil )
          command.run( params, configuration, options )
        end
        
      end
      
    end
    
  end
  
end
