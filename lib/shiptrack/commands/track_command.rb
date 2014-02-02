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
      Launchy.open( tracking_url_from_shipment( shipment ) )
    end
    
    private
    
      def tracking_url_from_shipment( shipment )
        case shipment.ship_method
        when 'UPS'
          "http://wwwapps.ups.com/WebTracking/track?trackNums=#{shipment.ship_tracking_number}"
        when 'Purolator'
          "http://www.purolator.com/purolator/ship-track/tracking-summary.page?search=#{shipment.ship_tracking_number}"
        when 'Fedex'
          "https://www.fedex.com/fedextrack/?tracknumbers=#{shipment.ship_tracking_number}&locale=en_CA&cntry_code=ca_english"
        when 'Canada Post'
          "http://www.canadapost.ca/cpotools/apps/track/business/findByTrackNumber?trackingNumber=#{shipment.ship_tracking_number}&amp;LOCALE=en"
        #when 'USPS'
        else
          raise "Unrecognized ship method (#{shipment.ship_method})"
        end
      end
    
  end
  
end
