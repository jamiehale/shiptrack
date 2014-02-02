# This file is part of ShipTrack.
#
# Copyright 2014 Jamie Hale <jamie@smallarmyofnerds.com>
#
# ShipTrack is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# ShipTrack is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with ShipTrack. If not, see <http://www.gnu.org/licenses/>.

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
    
    def each( &blk )
      @items.each( &blk )
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
        :path => "#{ENV['HOME']}/.shiptrack",
        :tracking_urls => {
          'UPS' => 'http://wwwapps.ups.com/WebTracking/track?trackNums=!!!',
          'Purolator' => 'http://www.purolator.com/purolator/ship-track/tracking-summary.page?search=!!!',
          'Fedex' => 'https://www.fedex.com/fedextrack/?tracknumbers=!!!&locale=en_CA&cntry_code=ca_english',
          'Canada Post' => 'http://www.canadapost.ca/cpotools/apps/track/business/findByTrackNumber?trackingNumber=!!!&amp;LOCALE=en'
        }
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
