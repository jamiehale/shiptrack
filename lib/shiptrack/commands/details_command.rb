module ShipTrack
  
  class DetailsCommand < Command
    
    def initialize( dumper )
      super( 'details' )
      describe 'Shows shipment details'
      handle_parameters [ CommandParameter.new( :index, :int ) ]
      @dumper = dumper
    end
    
    def run( params, configuration, options )
      all_shipments = ShipmentList.load( configuration[ :active_shipments_filepath ] )
      @dumper.dump( all_shipments.get_by_index( params[ :index ] - 1 ) )
    end
    
  end
  
end
