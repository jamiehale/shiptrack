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
    
    def ordered?
      !order_date.nil?
    end
    
    def paid?
      !purchase_date.nil?
    end
    
    def shipped?
      !ship_date.nil?
    end
    
    def received?
      !receive_date.nil?
    end
    
    def state
      if ordered? and !paid? and !shipped? and !received?
        return 'ORDERED'
      elsif ordered? and paid? and !shipped? and !received?
        return 'PAID'
      elsif ordered? and paid? and shipped? and !received?
        return 'SHIPPED'
      elsif ordered? and paid? and shipped? and received?
        return 'RECEIVED'
      else
        return 'UNKNOWN'
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
