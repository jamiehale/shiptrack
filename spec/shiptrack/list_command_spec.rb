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
  
  describe ListCommand do
    
    let( :dumper ) { double( 'dumper' ) }
    let( :command ) { ListCommand.new( dumper ) }
    
    before( :each ) do
      dumper.stub( :dump_list_line )
    end
    
    describe '.initialize' do
      
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
      
      let( :params ) { {} }
      let( :configuration ) { { :active_shipments_filepath => 'some/path' } }
      let( :shipment_list ) { double( 'shipment_list' ) }
      let( :shipment ) { double( 'shipment' ) }
      
      before( :each ) do
        ShipmentList.stub( :load ).and_return( shipment_list )
        shipment_list.stub( :each ).and_yield( 0, shipment )
        shipment.stub( :name )
        shipment.stub( :state )
      end
      
      it 'loads the active shipment list' do
        ShipmentList.should_receive( :load ).with( 'some/path' )
        command.run( params, configuration, {} )
      end
      
      it 'dumps the shipment' do
        dumper.should_receive( :dump_list_line ).with( 1, shipment )
        command.run( params, configuration, {} )
      end
      
    end
    
  end
  
end
