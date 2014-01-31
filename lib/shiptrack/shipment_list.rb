module ShipTrack
  
  class ShipmentList
    
    def initialize( shipments = [] )
      @shipments = shipments
    end
    
    def self.load( filename )
      shipments = YAML.load_file( filename )
      ShipmentList.new( shipments.map { |s| Shipment.new( s ) } )
    end
    
    def save( filename )
      File.open( filename, 'w' ) do |f|
        f.write( to_yaml )
      end
    end
    
    def add( shipment )
      @shipments << shipment
    end
    
    def delete( index )
      @shipments.delete_at( index - 1 )
    end
    
    def to_yaml
      @shipments.map{ |s| s.to_hash }.to_yaml
    end
    
    def each
      i = 0
      @shipments.each do |s|
        yield i, s
        i += 1
      end
    end
    
    def get_by_index( index )
      @shipments[ index ]
    end
    
  end
  
end
