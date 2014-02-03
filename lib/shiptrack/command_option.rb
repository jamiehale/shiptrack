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
  
  class CommandOption
    
    attr_reader :name, :type, :description
    
    def initialize( name, type, description = '' )
      @name = name
      @type = type
      @description = description
    end
    
    def name_as_option_string
      @name.to_s.sub( '_', '-' )
    end
    
    def ==( other )
      return false unless other.name == @name
      return false unless other.type == @type
      return false unless other.description == @description
      true
    end
    
    def self.name_string_to_symbol( s )
      s.sub( '-', '_' ).to_sym
    end
    
  end
  
end
