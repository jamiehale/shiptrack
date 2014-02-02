module ShipTrack
  
  class ShipmentDumper
    
    def initialize( stream = $stdout )
      @stream = stream
    end
    
    def dump( shipment )
      line 'Name', shipment.name
      line 'Vendor', shipment.vendor unless shipment.vendor.nil?
      line 'State', shipment.state
      line 'Ordered', shipment.order_date unless shipment.order_date.nil?
      if shipment.paid?
        space
        line 'Paid', shipment.purchase_date unless shipment.purchase_date.nil?
        if shipment.shipped?
          space
          line 'Shipped', shipment.ship_date unless shipment.ship_date.nil?
          line 'Method', shipment.ship_method unless shipment.ship_method.nil?
          line 'Tracking Number', shipment.ship_tracking_number unless shipment.ship_tracking_number.nil?
          if shipment.received?
            space
            line 'Received', shipment.receive_date unless shipment.receive_date.nil?
          end
        end
      end
    end
    
    def dump_list_line( index, shipment )
      @stream.puts "#{index}: #{shipment.name} (from #{shipment.vendor}) [#{shipment.state}]"
    end
    
    private
    
      def line( name, value )
        @stream.puts '%15s: %s' % [ name, value ]
      end
      
      def space
        @stream.puts ''
      end
      
  end
  
end
