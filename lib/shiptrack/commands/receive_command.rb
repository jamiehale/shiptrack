module ShipTrack
  
  class ReceiveCommand < Command
    
    def initialize
      super( 'receive' )
      describe 'Mark a shipment as RECEIVED'
      handle_parameters [ [ :index, :int ] ]
      handle_option :date, { :type => :string }
    end
    
    def run( params, configuration, options )
      shipment_list = ShipmentList.load( configuration[ :active_shipments_filepath ] )
      shipment = shipment_list.get_by_index( params[ :index ] )
      if options[ :date ].nil?
        shipment.receive_date = DateTime.now.strftime( '%Y-%m-%d' )
      else
        shipment.receive_date = options[ :date ]
      end
      shipment_list.save( configuration[ :active_shipments_filepath ] )
    end
    
  end
  
end
