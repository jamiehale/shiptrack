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
  
  describe DetailsCommand do
    
    let( :dumper ) { double( 'dumper' ) }
    let( :command ) { DetailsCommand.new( dumper ) }
    
    before( :each ) do
      dumper.stub( :dump )
    end
    
    describe '.initialize' do
      
      it 'has a name' do
        expect( command.name ).to eq 'details'
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
      
      let( :params ) { { :index => 1 } }
      let( :configuration ) { { :active_shipments_filepath => 'some/path' } }
      let( :shipment_list ) { double( 'shipment_list' ) }
      let( :shipment ) { double( 'shipment' ) }
      
      before( :each ) do
        ShipmentList.stub( :load ).and_return( shipment_list )
        shipment_list.stub( :get_by_index ).and_return( shipment )
        shipment.stub( :name ).and_return( 'Something' )
        shipment.stub( :state ).and_return( 'SHIPPED' )
        shipment.stub( :vendor ).and_return( 'Somebody' )
        shipment.stub( :order_date ).and_return( '2014-01-01' )
        shipment.stub( :purchase_date ).and_return( '2014-01-02' )
        shipment.stub( :ship_date ).and_return( '2014-01-03' )
        shipment.stub( :ship_method ).and_return( 'UPS' )
        shipment.stub( :ship_tracking_number ).and_return( '12345' )
        shipment.stub( :receive_date ).and_return( nil )
        $stdout.stub( :puts )
      end
      
      it 'loads the active shipment list' do
        ShipmentList.should_receive( :load ).with( 'some/path' )
        command.run( params, configuration, {} )
      end
      
      it 'fails if the index is invalid' do
        shipment_list.stub( :get_by_index ).and_raise 'Invalid index'
        expect { command.run( params, configuration, {} ) }.to raise_error 'Invalid index'
      end
      
      it 'defers to the dumper for output' do
        dumper.should_receive( :dump ).with( shipment )
        command.run( params, configuration, {} )
      end
      
    end
    
  end
  
end
