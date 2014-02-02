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
  
  class CommandProcessor
    
    attr_reader :commands
    
    def initialize
      @commands = {}
    end
    
    def handle( command )
      @commands[ command.name ] = command
      command.command_processor = self
    end
    
    def run( name, configuration, args = [] )
      raise 'No such command' unless @commands.has_key?( name )
      new_args, options = @commands[ name ].parse_options( args )
      @commands[ name ].run( new_args, configuration, options )
    end
    
    def each_command( &blk )
      sorted_commands.each( &blk )
    end
    
    def handles?( name )
      @commands.has_key?( name )
    end
    
    def []( name )
      @commands[ name ]
    end
    
    def self.initialize( &blk )
      command_processor = CommandProcessor.new
      command_processor.instance_eval( &blk )
      command_processor
    end
    
    private
    
      def sorted_commands
        @commands.values.sort{|a,b| a.name <=> b.name}
      end
    
  end
  
end
