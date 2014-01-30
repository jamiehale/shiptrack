module ShipTrack
  
  class Shipment
    
    attr_accessor :name, :vendor, :order_date
    attr_reader :purchase_date, :ship_date, :receive_date
    attr_accessor :ship_method, :ship_tracking_number
    
    def initialize( params = {} )
      fields.each do |field_name|
        instance_variable_set( "@#{field_name}", params[ field_name ] )
      end
    end
    
    def to_hash
      fields.inject( {} ) { |d,n| d[ n ] = instance_variable_get( "@#{n}" ) unless instance_variable_get( "@#{n}" ).nil? ; d }
    end
    
    def name_matches( s )
      @name.downcase[ 0, s.length ] = s.downcase
    end
    
    def purchase_date=( date )
      @purchase_date = date
      @order_date = date if @order_date.nil?
    end
    
    def ship_date=( date )
      @ship_date = date
      @purchase_date = date if @purchase_date.nil?
      @order_date = date if @order_date.nil?
    end
    
    def receive_date=( date )
      @receive_date = date
      @ship_date = date if @ship_date.nil?
      @purchase_date = date if @purchase_date.nil?
      @order_date = date if @order_date.nil?
    end
    
    def state
      if order_date.nil?
        return "UNKNOWN"
      else
        if purchase_date.nil?
          return "ORDERED"
        else
          if ship_date.nil?
            return "PAID"
          else
            if receive_date.nil?
              return "SHIPPED"
            else
              return "RECEIVED"
            end
          end
        end
      end
    end
    
    private
    
      def fields
        [
          :name,
          :vendor,
          :order_date,
          :purchase_date,
          :ship_date,
          :ship_method,
          :ship_tracking_number,
          :receive_date
        ]
      end
      
  end
  
end
