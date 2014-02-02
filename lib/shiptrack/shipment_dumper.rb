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

module ShipTrack
  
  class ShipmentDumper
    
    def initialize( stream = $stdout )
      @stream = stream
    end
    
    def dump( shipment )
      line 'Name', shipment.name
      line 'Vendor', shipment.vendor unless shipment.vendor.nil?
      line 'State', shipment.state
      line 'Ordered', shipment.order_date unless shipment.order_date.nil?
      if shipment.paid?
        space
        line 'Paid', shipment.payment_date unless shipment.payment_date.nil?
        if shipment.shipped?
          space
          line 'Shipped', shipment.ship_date unless shipment.ship_date.nil?
          line 'Method', shipment.ship_method unless shipment.ship_method.nil?
          line 'Tracking Number', shipment.tracking_number unless shipment.tracking_number.nil?
          if shipment.received?
            space
            line 'Received', shipment.receipt_date unless shipment.receipt_date.nil?
          end
        end
      end
    end
    
    def dump_list_line( index, shipment )
      @stream.puts "#{index}: #{shipment.name} (from #{shipment.vendor}) [#{shipment.state}]"
    end
    
    private
    
      def line( name, value )
        @stream.puts '%15s: %s' % [ name, value ]
      end
      
      def space
        @stream.puts ''
      end
      
  end
  
end
