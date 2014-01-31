module ShipTrack
  
  class PurchaseCommand < Command
    
    def initialize
      super( 'purchase' )
      describe 'Record a purchase for tracking'
      handle_parameters [ CommandParameter.new( :name, :string ) ]
      handle_option CommandOption.new( :vendor, :string )
      handle_option CommandOption.new( :date, :string )
    end
    
    def run( params, configuration, options )
      shipment = Shipment.new( { :name => params[ :name ] } )
      shipment.vendor = options[ :vendor ] unless options[ :vendor ].nil?
      shipment.purchase_date = purchase_date( options )
      add_to_active_shipment_list( shipment, configuration )
    end
    
    private
    
      def purchase_date( options )
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
