module ShipTrack
  
  class ShipmentDumper
    
    def initialize( stream = $stdout )
      @stream = stream
    end
    
    def dump( shipment )
      @stream.puts "Name: #{shipment.name} [#{shipment.state}]"
      @stream.puts "Vendor: #{shipment.vendor}" unless shipment.vendor.nil?
      @stream.puts "Order Date: #{shipment.order_date}" unless shipment.order_date.nil?
      @stream.puts "Purchase Date: #{shipment.purchase_date}" unless shipment.purchase_date.nil?
      @stream.puts "Ship Date: #{shipment.ship_date}" unless shipment.ship_date.nil?
      @stream.puts "Ship Method: #{shipment.ship_method}" unless shipment.ship_method.nil?
      @stream.puts "Tracking Number: #{shipment.ship_tracking_number}" unless shipment.ship_tracking_number.nil?
      @stream.puts "Received: #{shipment.receive_date}" unless shipment.receive_date.nil?
    end
    
    def dump_list_line( index, shipment )
      @stream.puts "#{index}: #{shipment.name} (from #{shipment.vendor}) [#{shipment.state}]"
    end
    
  end
  
end
