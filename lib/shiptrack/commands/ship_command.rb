module ShipTrack
  
  class ShipCommand < Command
    
    def initialize
      super( 'ship' )
      describe 'Mark a shipment as SHIPPED'
      handle_parameters [ [ :index, :int ] ]
      handle_option :date, { :type => :string }
      handle_option :method, { :type => :string }
      handle_option :tracking_number, { :type => :string }
    end
    
    def run( params, configuration, options )
      shipment_list = ShipmentList.load( configuration[ :active_shipments_filepath ] )
      shipment = shipment_list.get_by_index( params[ :index ] )
      if options[ :date ].nil?
        shipment.ship_date = DateTime.now.strftime( '%Y-%m-%d' )
      else
        shipment.ship_date = options[ :date ]
      end
      shipment.ship_method = options[ :method ] unless options[ :method ].nil?
      shipment.ship_tracking_number = options[ :tracking_number ] unless options[ :tracking_number ].nil?
      shipment_list.save( configuration[ :active_shipments_filepath ] )
    end
    
  end
  
end
