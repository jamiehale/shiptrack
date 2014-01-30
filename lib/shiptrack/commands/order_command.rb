module ShipTrack
  
  class OrderCommand < Command
    
    def initialize
      super( 'order' )
      describe 'Record an order'
      handle_parameters [ [ :name, :string ] ]
      handle_option :vendor, { :type => :string }
      handle_option :date, { :type => :string }
    end

    def run( params, configuration, options )
      shipment = Shipment.new( { :name => params[ :name ] } )
      shipment.vendor = options[ :vendor ] unless options[ :vendor ].nil?
      if options[ :date ].nil?
        shipment.order_date = DateTime.now.strftime( '%Y-%m-%d' )
      else
        shipment.order_date = options[ :date ]
      end
      shipment_list = ShipmentList.load( configuration[ :active_shipments_filepath ] )
      shipment_list.add( shipment )
      shipment_list.save( configuration[ :active_shipments_filepath ] )
    end

  end

end
