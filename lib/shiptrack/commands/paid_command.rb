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
      shipment.purchase_date = purchase_date( options )
      shipment_list.save( configuration[ :active_shipments_filepath ] )
    end
    
    private
    
      def purchase_date( options )
        return options[ :date ] unless options[ :date ].nil?
        DateTime.now.strftime( '%Y-%m-%d' )
      end

  end

end
