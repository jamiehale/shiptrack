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
  
  class LoggingStream
    
    def initialize
      @lines = []
    end
    
    def puts( s )
      @lines << s
    end
    
    def includes?( s )
      @lines.each do |l|
        return true if l.include? s
      end
      false
    end
    
  end
  
  describe ShipmentDumper do
    
    it 'builds' do
      ShipmentDumper.new
    end
    
    describe '#dump' do
      
      let( :stream ) { LoggingStream.new }
      let( :dumper ) { ShipmentDumper.new( stream ) }
      let( :shipment ) { double( 'shipment' ) }
      
      before( :each ) do
        shipment.stub( :name ).and_return( 'Something' )
        shipment.stub( :state ).and_return( 'RECEIVED' )
        shipment.stub( :vendor ).and_return( 'Somebody' )
        shipment.stub( :order_date ).and_return( '2014-01-01' )
        shipment.stub( :purchase_date ).and_return( '2014-01-02' )
        shipment.stub( :ship_date ).and_return( '2014-01-03' )
        shipment.stub( :ship_method ).and_return( 'UPS' )
        shipment.stub( :ship_tracking_number ).and_return( '12345' )
        shipment.stub( :receive_date ).and_return( '2014-01-04' )
        shipment.stub( :paid? ).and_return( true )
        shipment.stub( :shipped? ).and_return( true )
        shipment.stub( :received? ).and_return( true )
        dumper.dump( shipment )
      end
      
      it 'dumps the shipment name' do
        expect( stream.includes? 'Something' ).to be_true
      end
      
      it 'dumps the shipment state' do
        expect( stream.includes? 'RECEIVED' ).to be_true
      end
      
      it 'dumps the vendor' do
        expect( stream.includes? 'Somebody' ).to be_true
      end
      
      it 'dumps the order date' do
        expect( stream.includes? '2014-01-01' ).to be_true
      end
      
      it 'dumps the purchase date' do
        expect( stream.includes? '2014-01-02' ).to be_true
      end
      
      it 'dumps the ship date' do
        expect( stream.includes? '2014-01-03' ).to be_true
      end
      
      it 'dumps the ship method' do
        expect( stream.includes? 'UPS' ).to be_true
      end
      
      it 'dumps the tracking number' do
        expect( stream.includes? '12345' ).to be_true
      end
      
      it 'dumps the receipt date' do
        expect( stream.includes? '2014-01-04' ).to be_true
      end
      
    end
    
    describe '#dump_list_line' do
      
      let( :stream ) { LoggingStream.new }
      let( :dumper ) { ShipmentDumper.new( stream ) }
      let( :shipment ) { double( 'shipment' ) }
      
      before( :each ) do
        shipment.stub( :name ).and_return( 'Something' )
        shipment.stub( :state ).and_return( 'RECEIVED' )
        shipment.stub( :vendor ).and_return( 'Somebody' )
        shipment.stub( :order_date ).and_return( '2014-01-01' )
        shipment.stub( :purchase_date ).and_return( '2014-01-02' )
        shipment.stub( :ship_date ).and_return( '2014-01-03' )
        shipment.stub( :ship_method ).and_return( 'UPS' )
        shipment.stub( :ship_tracking_number ).and_return( '12345' )
        shipment.stub( :receive_date ).and_return( '2014-01-04' )
        dumper.dump_list_line( 172, shipment )
      end
      
      it 'dumps the index' do
        expect( stream.includes? '172' ).to be_true
      end
      
      it 'dumps the shipment name' do
        expect( stream.includes? 'Something' ).to be_true
      end
      
      it 'dumps the vendor' do
        expect( stream.includes? 'Somebody' ).to be_true
      end
      
      it 'dumps the state' do
        expect( stream.includes? 'RECEIVED' ).to be_true
      end
      
    end
      
  end
  
end
