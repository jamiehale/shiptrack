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
      @commands.values.sort{|a,b| a.name <=> b.name}.each( &blk )
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
    
  end
  
end
