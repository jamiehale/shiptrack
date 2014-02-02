module ShipTrack
  
  class Configuration
    
    def initialize( configuration_file )
      @parameters = {}
      configuration_file.each do |key,value|
        @parameters[ key ] = value
      end
    end
    
    def []=( name, value )
      @parameters[ name ] = value
    end
    
    def []( name )
      @parameters[ name ]
    end
    
    def each( &blk )
      @parameters.each( &blk )
    end
    
    def delete( name )
      @parameters.delete( name )
    end
    
    def has_key?( name )
      @parameters.has_key? name
    end
    
  end
  
end
