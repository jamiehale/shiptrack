module ShipTrack
  
  class ReceiveCommand < Command
    
    def initialize
      super( 'receive' )
      describe 'Mark a shipment as RECEIVED'
      handle_parameters [ CommandParameter.new( :index, :int ) ]
      handle_option CommandOption.new( :date, :string )
    end
    
    def run( params, configuration, options )
      shipment_list = ShipmentList.load( configuration[ :active_shipments_filepath ] )
      shipment = shipment_list.get_by_index( params[ :index ] - 1 )
      shipment.receive_date = receive_date( options )
      shipment_list.save( configuration[ :active_shipments_filepath ] )
    end

    private
    
      def receive_date( options )
        return options[ :date ] unless options[ :date ].nil?
        DateTime.now.strftime( '%Y-%m-%d' )
      end
      
  end
  
end
