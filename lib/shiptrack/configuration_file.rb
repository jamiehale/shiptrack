module ShipTrack
  
  class ConfigurationFile

    def initialize( items = {} )
      @items = keys_strings_to_symbols( items )
    end
    
    def empty?
      @items.empty?
    end
    
    def []( name )
      @items[ name ]
    end
    
    def []=( name, value )
      if name.is_a? String
        @items[ name.to_sym ] = keys_strings_to_symbols( value )
      else
        @items[ name ] = keys_strings_to_symbols( value )
      end
    end
    
    def self.load( filename )
      return ConfigurationFile.new( YAML.load_file( filename ) ) if File.exists?( filename )
      new_configuration_file = ConfigurationFile.new( defaults )
      new_configuration_file.save( filename )
      new_configuration_file
    end
    
    def save( filename )
      File.open( filename, 'w' ) do |f|
        f.write( to_yaml )
      end
    end
    
    def to_yaml
      key_symbols_to_strings( @items ).to_yaml
    end
    
    def self.defaults
      {
        :path => "#{ENV['HOME']}/.shiptrack"
      }
    end

    private
    
      def keys_strings_to_symbols( thing )
        return thing unless thing.is_a? Hash
        filtered_items = {}
        thing.each do |key,value|
          if key.is_a? String
            filtered_items[ key.to_sym ] = keys_strings_to_symbols( value )
          else
            filtered_items[ key ] = keys_strings_to_symbols( value )
          end
        end
        filtered_items
      end
      
      def key_symbols_to_strings( thing )
        return thing unless thing.is_a? Hash
        filtered_items = {}
        thing.each do |key,value|
          if key.is_a? Symbol
            filtered_items[ key.to_s ] = key_symbols_to_strings( value )
          else
            filtered_items[ key ] = key_symbols_to_strings( value )
          end
        end
        filtered_items
      end
      
  end
  
end
