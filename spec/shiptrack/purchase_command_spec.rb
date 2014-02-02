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
  
  describe PurchaseCommand do
    
    describe '.initialize' do
      
      let( :command ) { PurchaseCommand.new }
    
      it 'has a name' do
        expect( command.name ).to eq 'purchase'
      end
    
      it 'has a description' do
        expect( command.description ).to_not be_nil
      end
    
      it 'handles the parameter set [name,string]' do
        expect( command.parameter_sets ).to include [ CommandParameter.new( :name, :string ) ]
      end
    
      it 'only handles 1 parameter set' do
        expect( command.parameter_sets.size ).to eq 1
      end

      it 'handles a vendor option' do
        expect( command.options ).to include CommandOption.new( :vendor, :string )
      end
      
      it 'handles a date option' do
        expect( command.options ).to include CommandOption.new( :date, :string )
      end
      
      it 'only handles 2 option' do
        expect( command.options.size ).to eq 2
      end
      
    end
    
    describe '#run' do
      
      let( :command ) { PurchaseCommand.new }
      let( :params ) { { :name => 'Something' } }
      let( :configuration ) { { :active_shipments_filepath => 'some/path' } }
      let( :shipment_list ) { double( 'shipment_list' ) }
      let( :shipment ) { double( 'shipment' ) }
      
      before( :each ) do
        Shipment.stub( :new ).and_return( shipment )
        shipment.stub( :payment_date= )
        ShipmentList.stub( :load ).and_return( shipment_list )
        shipment_list.stub( :add )
        shipment_list.stub( :save )
      end
  
      it 'creates a new shipment' do
        Shipment.should_receive( :new ).with( { :name => 'Something' } )
        command.run( params, configuration, {} )
      end
      
      it 'sets the payment date on the shipment' do
        shipment.should_receive( :payment_date= ).with( DateTime.now.strftime( '%Y-%m-%d' ) )
        command.run( params, configuration, {} )
      end
      
      it 'sets the payment date from an option' do
        shipment.should_receive( :payment_date= ).with( '2000-01-01' )
        command.run( params, configuration, { :date => '2000-01-01' } )
      end
      
      it 'loads the active shipment list' do
        ShipmentList.should_receive( :load ).with( 'some/path' )
        command.run( params, configuration, {} )
      end
      
      it 'adds the new shipment to the shipment list' do
        shipment_list.should_receive( :add ).with( shipment )
        command.run( params, configuration, {} )
      end
      
      it 'saves the shipment list' do
        shipment_list.should_receive( :save ).with( 'some/path' )
        command.run( params, configuration, {} )
      end
      
    end
    
  end
  
end
