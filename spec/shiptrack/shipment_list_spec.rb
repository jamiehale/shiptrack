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
  
  describe ShipmentList do
    
    describe 'default constructor' do
      
      let( :shipment_list ) { ShipmentList.new }
      
      it 'has no shipments' do
        expect( shipment_list.count ).to eq 0
      end
      
      it 'is empty' do
        expect( shipment_list ).to be_empty
      end
      
    end
    
    describe 'adding' do
      
      let( :shipment_1 ) { Shipment.new }
      let( :shipment_2 ) { Shipment.new }
      
      describe 'to empty list' do
        
        let( :shipment_list ) { ShipmentList.new }
        
        before( :each ) { shipment_list.add( shipment_1 ) }
        
        it 'has 1 shipment' do
          expect( shipment_list.count ).to eq 1
        end
        
        it 'is not empty' do
          expect( shipment_list ).to_not be_empty
        end
        
        it 'stores shipment at index 0' do
          expect( shipment_list.get_by_index( 0 ) ).to eq shipment_1
        end
        
      end
      
      describe 'to non-empty list' do
        
        let( :shipment_list ) { ShipmentList.new( [ shipment_1 ] ) }
        
        before( :each ) { shipment_list.add( shipment_2 ) }
        
        it 'has 2 shipments' do
          expect( shipment_list.count ).to eq 2
        end
        
        it 'is still not empty' do
          expect( shipment_list ).to_not be_empty
        end
        
        it 'stores shipment at index 1' do
          expect( shipment_list.get_by_index( 1 ) ).to eq shipment_2
        end
        
        it 'leaves old shipment at index 0' do
          expect( shipment_list.get_by_index( 0 ) ).to eq shipment_1
        end
        
      end
      
    end
    
    describe 'deleting' do
      
      let( :shipment_1 ) { Shipment.new }
      let( :shipment_2 ) { Shipment.new }
      
      describe 'from a single-entry list' do
        
        let( :shipment_list ) { ShipmentList.new( [ shipment_1 ] ) }
        
        before( :each ) { shipment_list.delete( 0 ) }
        
        it 'leaves a count of 0' do
          expect( shipment_list.count ).to eq 0
        end
        
        it 'leaves an empty list' do
          expect( shipment_list ).to be_empty
        end
        
      end
      
    end
    
    describe '#get_by_index' do
      
      let( :shipment_list ) { ShipmentList.new( [ build( :shipment ) ] ) }
      
      it 'fails with an invalid index' do
        expect { shipment_list.get_by_index( 4 ) }.to raise_error 'Invalid index'
      end
      
    end
    
    describe '.load' do
    
      let( :shipment ) { Shipment.new( { :name => 'Something', :vendor => 'Somebody', :order_date => '2014-01-01' } ) }
      
      before( :each ) do
        YAML.stub( :load_file ).and_return( [ shipment.to_hash ] )
        Shipment.stub( :new ).and_return( shipment )
      end
      
      it 'defers to YAML to load file' do
        YAML.should_receive( :load_file ).with( 'wankity' )
        ShipmentList.load( 'wankity' )
      end
      
      it 'creates a new shipment list from the list of shipment hashes' do
        ShipmentList.should_receive( :new ).with( [ shipment ] )
        ShipmentList.load( 'wankity' )
      end
      
    end
    
    describe '#save' do
      
      let( :shipment ) { Shipment.new( { :name => 'Something', :vendor => 'Somebody', :order_date => '2014-01-01' } ) }
      let( :shipment_list ) { ShipmentList.new( [ shipment ] ) }
      let( :file ) { double( 'file' ) }
      
      before( :each ) do
        File.stub( :open ).and_yield( file )
        file.stub( :write )
      end
      
      it 'opens the file' do
        File.should_receive( :open ).with( 'wankity', 'w' )
        shipment_list.save( 'wankity' )
      end
      
      it 'writes the YAML' do
        file.should_receive( :write ).with( shipment_list.to_yaml )
        shipment_list.save( 'wankity' )
      end
      
    end
    
  end
  
end
