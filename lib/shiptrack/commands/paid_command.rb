module ShipTrack
  
  class PaidCommand < Command
    
    def initialize
      super( 'paid' )
      describe 'Mark an ORDERED shipment as paid'
      handle_parameters [ CommandParameter.new( :index, :int ) ]
      handle_option CommandOption.new( :date, :string )
    end

    def run( params, configuration, options )
      shipment_list = ShipmentList.load( configuration[ :active_shipments_filepath ] )
      shipment = shipment_list.get_by_index( params[ :index ] - 1 )
      if options[ :date ].nil?
        shipment.purchase_date = DateTime.now.strftime( '%Y-%m-%d' )
      else
        shipment.purchase_date = options[ :date ]
      end
      shipment_list.save( configuration[ :active_shipments_filepath ] )
    end

  end

end
