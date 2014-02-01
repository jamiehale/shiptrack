module ShipTrack
  
  class ShipmentDumper
    
    def initialize( stream = $stdout )
      @stream = stream
    end
    
    def dump( shipment )
      @stream.puts "#{shipment.name}"
      @stream.puts "#{shipment.state}"
      @stream.puts "#{shipment.vendor}"
      @stream.puts "#{shipment.order_date}"
      @stream.puts "#{shipment.purchase_date}"
      @stream.puts "#{shipment.ship_date}"
      @stream.puts "#{shipment.ship_method}"
      @stream.puts "#{shipment.ship_tracking_number}"
      @stream.puts "#{shipment.receive_date}"
    end
    
  end
  
end
