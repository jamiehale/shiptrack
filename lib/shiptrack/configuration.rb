module ShipTrack
  
  class Configuration
    
    def initialize( params )
      @parameters = params
    end
    
    def save( filename )
      File.open( filename, 'w' ) do |f|
        f.write( to_yaml )
      end
    end
    
    def self.load( filename )
      ensure_file_exists( filename )
      Configuration.new( YAML.load_file( filename ) )
    end
    
    def self.load_and_validate( filename )
      user_config = Configuration.load( filename )
      user_config.ensure_valid
      user_config
    end
    
    def ensure_valid
      raise 'No path defined in user config' unless has_key? 'path'
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
    
    def to_yaml
      @parameters.to_yaml
    end
    
    private
    
      def self.ensure_file_exists( filename )
        Configuration.new( defaults ).save( filename ) unless File.exists?( filename )
      end
      
      def self.defaults
        {
          'path' => "#{ENV['HOME']}/.shiptrack"
        }
      end

  end
  
end
