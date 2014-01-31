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
