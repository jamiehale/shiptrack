require 'launchy'

module ShipTrack
  
  class TrackCommand < Command
    
    def initialize
      super( 'track' )
      describe 'Tracks a shipment'
      handle_parameters [ [ :index, :int ] ]
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
        #when 'Canada Post'
        #when 'USPS'
        else
          raise "Unrecognized ship method (#{shipment.ship_method})"
        end
      end
    
  end
  
end
