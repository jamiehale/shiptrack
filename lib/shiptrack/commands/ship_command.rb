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
  
  class ShipCommand < Command
    
    def initialize
      super( 'ship' )
      describe 'Mark a shipment as SHIPPED'
      handle_parameters [ CommandParameter.new( :index, :int ) ]
      handle_option CommandOption.new( :date, :string, 'Specify the date on which the shipment was shipped' )
      handle_option CommandOption.new( :method, :string, 'Specify the method used to ship' )
      handle_option CommandOption.new( :tracking_number, :string, 'Specify the shipping tracking number' )
    end
    
    def run( params, configuration, options )
      shipment_list = ShipmentList.load( configuration[ :active_shipments_filepath ] )
      shipment = shipment_list.get_by_index( params[ :index ] - 1 )
      shipment.ship_date = ship_date( options )
      shipment.ship_method = options[ :method ] unless options[ :method ].nil?
      shipment.tracking_number = options[ :tracking_number ] unless options[ :tracking_number ].nil?
      shipment_list.save( configuration[ :active_shipments_filepath ] )
    end
    
    private
    
      def ship_date( options )
        return options[ :date ] unless options[ :date ].nil?
        DateTime.now.strftime( '%Y-%m-%d' )
      end
    
  end
  
end
