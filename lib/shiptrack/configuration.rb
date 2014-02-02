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
