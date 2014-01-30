module ShipTrack
  
  class DetailsCommand < Command
    
    def initialize
      super( 'details' )
      describe 'Shows shipment details'
      handle_parameters [ [ :index, :int ] ]
    end
    
    def run( params, configuration, options )
      all_shipments = ShipmentList.load( configuration[ :active_shipments_filepath ] )
      dump_details( all_shipments.get_by_index( params[ :index ] ) )
    end
    
    private
    
      def dump_details( shipment )
        puts "Name: #{shipment.name} [#{shipment.state}]"
        puts "Vendor: #{shipment.vendor}" unless shipment.vendor.nil?
        puts "Order Date: #{shipment.order_date}" unless shipment.order_date.nil?
        puts "Purchase Date: #{shipment.purchase_date}" unless shipment.purchase_date.nil?
        puts "Ship Date: #{shipment.ship_date}" unless shipment.ship_date.nil?
        puts "Ship Method: #{shipment.ship_method}" unless shipment.ship_method.nil?
        puts "Tracking Number: #{shipment.ship_tracking_number}" unless shipment.ship_tracking_number.nil?
        puts "Received: #{shipment.receive_date}" unless shipment.receive_date.nil?
      end
      
  end
  
end
