module ShipTrack
  
  class VersionCommand < Command
    
    def initialize
      super( 'version' )
      describe 'Displays the version'
      handle_no_parameters
    end
    
    def run( parameters, configuration, options )
      puts "#{$program} version #{$VERSION}"
    end
    
  end
  
end
