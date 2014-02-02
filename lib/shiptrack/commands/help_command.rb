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
  
  class HelpCommand < Command
    
    def initialize
      super( 'help' )
      describe 'Shows information about sdoc commands'
      handle_parameters [ CommandParameter.new( :command, :string ) ]
    end
    
    def run( parameters, configuration, options )
      show_help( parameters[ :command ] )
    end
    
    private
    
      def show_help( command_name )
        raise "No such command '#{command_name}'" unless command_processor.handles?( command_name )
        command_processor[ command_name ].usage
      end
      
  end
  
end
