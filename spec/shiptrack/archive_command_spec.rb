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
  
  describe ArchiveCommand do
    
    describe '.initialize' do
      
      let( :command ) { ArchiveCommand.new }
    
      it 'has a name' do
        expect( command.name ).to eq 'archive'
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
      
      let( :command ) { ArchiveCommand.new }
      let( :params ) { { :index => 1 } }
      let( :configuration ) { {
        :active_shipments_filepath => 'some/path',
        :archive_path => 'archive/path',
        :active_archive_filepath => 'active/archive/filepath' } }
      let( :shipment_list ) { double( 'shipment_list' ) }
      let( :archive_list ) { double( 'archive_list' ) }
      let( :shipped_shipment ) { build( :shipped_shipment ) }
      let( :received_shipment ) { build( :received_shipment ) }
      
      before( :each ) do
        ShipmentList.stub( :load ).and_return( shipment_list, archive_list )
        shipment_list.stub( :each ).and_yield( 0, shipped_shipment ).and_yield( 1, received_shipment )
        shipment_list.stub( :delete )
        shipment_list.stub( :save )
        archive_list.stub( :add )
        archive_list.stub( :save )
        File.stub( :directory? ).and_return( true )
        File.stub( :exists? ).and_return( true )
      end
      
      it 'loads the active shipment list' do
        ShipmentList.should_receive( :load ).with( 'some/path' )
        command.run( params, configuration, {} )
      end
      
      it 'loads the archive shipment list' do
        ShipmentList.should_receive( :load ).with( 'active/archive/filepath' )
        command.run( params, configuration, {} )
      end
      
      it 'adds the received shipment to the archive list' do
        archive_list.should_receive( :add ).with( received_shipment )
        command.run( params, configuration, {} )
      end
      
      it 'saves the archive list' do
        archive_list.should_receive( :save ).with( 'active/archive/filepath' )
        command.run( params, configuration, {} )
      end
      
      it 'deletes the shipment from the active shipment list' do
        shipment_list.should_receive( :delete ).with( 1 )
        command.run( params, configuration, {} )
      end
      
      it 'saves the active shipment list' do
        shipment_list.should_receive( :save ).with( 'some/path' )
        command.run( params, configuration, {} )
      end
      
    end
    
  end
  
end
