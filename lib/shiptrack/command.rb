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
  
  class Command
    
    attr_reader :name, :description, :parameter_sets
    attr_accessor :command_processor
    
    def initialize( name )
      @name = name
      @command_processor = nil
      @parameter_sets = []
      @options = {}
    end
    
    def options
      @options.values
    end
    
    def describe( d )
      @description = d
    end
    
    def handle_parameters( p )
      @parameter_sets << p
    end
    
    def handle_no_parameters
      @parameter_sets << []
    end
    
    def handle_option( option )
      @options[ option.name_as_option_string ] = option
    end
    
    def inject_command( name, configuration, args = [] )
      @command_processor.run( name, configuration, args )
    end
    
    def usage
      puts @description
      puts 'Usage:'
      @parameter_sets.each do |parameter_set|
        puts "       shiptrack #{name}#{options_tag}#{parameter_list(parameter_set)}"
      end
      describe_options
      exit
    end
    
    def options_tag
      if @options.empty?
        ''
      else
        ' [options]'
      end
    end
    
    def parameter_list( parameter_set )
      if parameter_set.empty?
        ''
      else
        ' ' + parameter_set.map{|p| '<' + p.name.to_s + '>'}.join( ' ' )
      end
    end
    
    def describe_options
      return if @options.empty?
      puts "Options:"
      @options.each do |name,option|
        puts "%35s    %s" % [ option_details( option ), option.description ]
      end
    end
    
    def option_details( option )
      if option.type == :string
        "--#{option.name_as_option_string} <#{option.name_as_option_string}>"
      else
        "--#{option.name_as_option_string}"
      end
    end
    
    def parse_options( args )
      options = {}
      read_parameters = []
      i = 0
      while ( i < args.size ) do
        if @options.keys.map{|o| "--#{o}"}.include? args[ i ]
          option_name = ( args[ i ] )[ 2..-1 ]
          option = @options[ option_name ]
          if option.type == :string
            if ( i + 1 ) < args.size
              options[ CommandOption.name_string_to_symbol( option_name ) ] = args[ i + 1 ]
              i += 1
            else
              usage
            end
          elsif option.type == :flag
            options[ CommandOption.name_string_to_symbol( option_name ) ] = true
          else
            raise "Invalid option type #{option.type}"
          end
        else
          read_parameters << args[ i ]
        end
        i += 1
      end
      parameters = build_parameters( read_parameters )
      [ parameters, options ]
    end
    
    private
    
      def build_parameters( read_parameters )
        parameters = {}
        @parameter_sets.each do |parameter_set|
          if read_parameters.size == parameter_set.size
            0.upto( read_parameters.size - 1 ) do |i|
              if parameter_set[ i ].type == :int
                parameters[ parameter_set[ i ].name ] = read_parameters[ i ].to_i
              else
                parameters[ parameter_set[ i ].name ] = read_parameters[ i ]
              end
            end
            return parameters
          end
        end
        usage
      end
      
  end
  
end
