module ShipTrack
  
  class CommandParameter
    
    attr_reader :name, :type
    
    def initialize( name, type )
      @name = name
      @type = type
    end
    
    def ==( other )
      return false unless other.name == @name
      return false unless other.type == @type
      true
    end
    
  end
  
end
