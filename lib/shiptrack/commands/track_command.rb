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

require 'launchy'

module ShipTrack
  
  class TrackCommand < Command
    
    def initialize
      super( 'track' )
      describe 'Tracks a shipment'
      handle_parameters [ CommandParameter.new( :index, :int ) ]
    end
    
    def run( params, configuration, options )
      all_shipments = ShipmentList.load( configuration[ :active_shipments_filepath ] )
      shipment = all_shipments.get_by_index( params[ :index ] - 1 )
      Launchy.open( tracking_url_from_shipment( shipment, configuration[ :tracking_urls ] ) )
    end
    
    private
    
      def tracking_url_from_shipment( shipment, tracking_urls )
        raise "Unrecognized ship method (#{shipment.ship_method})" unless tracking_urls.has_key?( shipment.ship_method.to_sym )
        tracking_urls[ shipment.ship_method.to_sym ].sub( /!!!/, shipment.ship_tracking_number )
      end
    
  end
  
end
