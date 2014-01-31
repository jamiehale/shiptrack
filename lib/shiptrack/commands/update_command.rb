module ShipTrack
  
  class UpdateCommand < Command
    
    def initialize
      super( 'update' )
      describe 'Updates attributes of a shipment'
      handle_parameters [ [ :index, :int ] ]
      handle_option :name, { :type => :string }
      handle_option :vendor, { :type => :string }
      handle_option :order_date, { :type => :string }
      handle_option :purchase_date, { :type => :string }
      handle_option :ship_date, { :type => :string }
      handle_option :ship_method, { :type => :string }
      handle_option :tracking_number, { :type => :string }
      handle_option :receive_date, { :type => :string }
      handle_option :clear_receipt, { :type => :flag }
      handle_option :clear_shipping, { :type => :flag }
      handle_option :clear_payment, { :type => :flag }
    end
    
    def run( params, configuration, options )
      all_shipments = ShipmentList.load( configuration[ :active_shipments_filepath ] )
      shipment = all_shipments.get_by_index( params[ :index ] - 1 )
      update_order( shipment, options )
      update_payment( shipment, options )
      update_shipping( shipment, options )
      update_receipt( shipment, options )
      clear_payment( shipment, options )
      clear_shipping( shipment, options )
      clear_receipt( shipment, options )
      all_shipments.save( configuration[ :active_shipments_filepath ] )
    end
    
    private
    
      def update_order( shipment, options )
        shipment.name = options[ :name ] unless options[ :name ].nil?
        shipment.vendor = options[ :vendor ] unless options[ :vendor ].nil?
        shipment.order_date = options[ :order_date ] unless options[ :order_date ].nil?
      end
      
      def update_payment( shipment, options )
        shipment.purchase_date = options[ :purchase_date ] unless options[ :purchase_date ].nil?
      end
      
      def update_shipping( shipment, options )
        shipment.ship_date = options[ :ship_date ] unless options[ :ship_date ].nil?
        shipment.ship_method = options[ :ship_method ] unless options[ :ship_method ].nil?
        shipment.ship_tracking_number = options[ :tracking_number ] unless options[ :tracking_number ].nil?
      end
      
      def update_receipt( shipment, options )
        shipment.receive_date = options[ :receive_date ] unless options[ :receive_date ].nil?
      end
      
      def clear_payment( shipment, options )
        unless options[ :clear_payment ].nil?
          shipment.purchase_date = nil
          shipment.ship_date = nil
          shipment.ship_method = nil
          shipment.ship_tracking_number = nil
          shipment.receive_date = nil
        end
      end
      
      def clear_shipping( shipment, options )
        unless options[ :clear_shipping ].nil?
          shipment.ship_date = nil
          shipment.ship_method = nil
          shipment.ship_tracking_number = nil
          shipment.receive_date = nil
        end
      end
      
      def clear_receipt( shiptment, options )
        unless options[ :clear_receipt ].nil?
          shipment.receive_date = nil
        end
      end
    
  end
  
end
