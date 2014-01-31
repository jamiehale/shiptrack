module ShipTrack
  
  class ShipCommand < Command
    
    def initialize
      super( 'ship' )
      describe 'Mark a shipment as SHIPPED'
      handle_parameters [ CommandParameter.new( :index, :int ) ]
      handle_option CommandOption.new( :date, :string )
      handle_option CommandOption.new( :method, :string )
      handle_option CommandOption.new( :tracking_number, :string )
    end
    
    def run( params, configuration, options )
      shipment_list = ShipmentList.load( configuration[ :active_shipments_filepath ] )
      shipment = shipment_list.get_by_index( params[ :index ] - 1 )
      shipment.ship_date = ship_date( options )
      shipment.ship_method = options[ :method ] unless options[ :method ].nil?
      shipment.ship_tracking_number = options[ :tracking_number ] unless options[ :tracking_number ].nil?
      shipment_list.save( configuration[ :active_shipments_filepath ] )
    end
    
    private
    
      def ship_date( options )
        return options[ :date ] unless options[ :date ].nil?
        DateTime.now.strftime( '%Y-%m-%d' )
      end
    
  end
  
end
