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
  
  class OrderCommand < Command
    
    def initialize
      super( 'order' )
      describe 'Record an order'
      handle_parameters [ CommandParameter.new( :name, :string ) ]
      handle_option CommandOption.new( :vendor, :string, 'Specify a vendor for the shipment' )
      handle_option CommandOption.new( :date, :string, 'Specify the date on which the shipment was ordered' )
    end

    def run( params, configuration, options )
      shipment = Shipment.new( { :name => params[ :name ] } )
      shipment.vendor = options[ :vendor ] unless options[ :vendor ].nil?
      shipment.order_date = order_date( options )
      add_to_active_shipment_list( shipment, configuration )
    end
    
    private
    
      def order_date( options )
        return options[ :date ] unless options[ :date ].nil?
        DateTime.now.strftime( '%Y-%m-%d' )
      end

      def add_to_active_shipment_list( shipment, configuration )
        shipment_list = ShipmentList.load( configuration[ :active_shipments_filepath ] )
        shipment_list.add( shipment )
        shipment_list.save( configuration[ :active_shipments_filepath ] )
      end
    
  end

end
