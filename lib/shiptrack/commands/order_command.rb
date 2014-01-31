module ShipTrack
  
  class OrderCommand < Command
    
    def initialize
      super( 'order' )
      describe 'Record an order'
      handle_parameters [ CommandParameter.new( :name, :string ) ]
      handle_option CommandOption.new( :vendor, :string )
      handle_option CommandOption.new( :date, :string )
    end

    def run( params, configuration, options )
      shipment = Shipment.new( { :name => params[ :name ] } )
      shipment.vendor = options[ :vendor ] unless options[ :vendor ].nil?
      shipment.order_date = order_date( options )
      add_to_active_shipment_list( shipment, configuration )
    end
    
    private
    
      def order_date( options )
        return options[ :date ] unless options[ :date ].nil?
        DateTime.now.strftime( '%Y-%m-%d' )
      end

      def add_to_active_shipment_list( shipment, configuration )
        shipment_list = ShipmentList.load( configuration[ :active_shipments_filepath ] )
        shipment_list.add( shipment )
        shipment_list.save( configuration[ :active_shipments_filepath ] )
      end
    
  end

end
