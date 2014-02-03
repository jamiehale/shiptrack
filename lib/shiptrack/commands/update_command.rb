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
  
  class UpdateCommand < Command
    
    def initialize
      super( 'update' )
      describe 'Updates attributes of a shipment'
      handle_parameters [ CommandParameter.new( :index, :int ) ]
      handle_option CommandOption.new( :name, :string, 'Specify the name of the shipment' )
      handle_option CommandOption.new( :vendor, :string, 'Specify the vendor' )
      handle_option CommandOption.new( :order_date, :string, 'Specify the date on which the shipment was ordered' )
      handle_option CommandOption.new( :payment_date, :string, 'Specify the date on which payment was made' )
      handle_option CommandOption.new( :ship_date, :string, 'Specify the date on which the shipment was shipped' )
      handle_option CommandOption.new( :ship_method, :string, 'Specify the shipping method' )
      handle_option CommandOption.new( :tracking_number, :string, 'Specify the tracking number' )
      handle_option CommandOption.new( :receipt_date, :string, 'Specify the date on which the shipment was received' )
      handle_option CommandOption.new( :clear_receipt, :flag, 'Clear the receipt date' )
      handle_option CommandOption.new( :clear_shipping, :flag, 'Clear shipping details' )
      handle_option CommandOption.new( :clear_payment, :flag, 'Clear payment date' )
    end
    
    def run( params, configuration, options )
      all_shipments = ShipmentList.load( configuration[ :active_shipments_filepath ] )
      shipment = all_shipments.get_by_index( params[ :index ] - 1 )
      update_order( shipment, options )
      update_payment( shipment, options )
      update_shipping( shipment, options )
      update_receipt( shipment, options )
      clear_payment( shipment, options )
      clear_shipping( shipment, options )
      clear_receipt( shipment, options )
      all_shipments.save( configuration[ :active_shipments_filepath ] )
    end
    
    private
    
      def update_order( shipment, options )
        shipment.name = options[ :name ] unless options[ :name ].nil?
        shipment.vendor = options[ :vendor ] unless options[ :vendor ].nil?
        shipment.order_date = options[ :order_date ] unless options[ :order_date ].nil?
      end
      
      def update_payment( shipment, options )
        shipment.payment_date = options[ :payment_date ] unless options[ :payment_date ].nil?
      end
      
      def update_shipping( shipment, options )
        shipment.ship_date = options[ :ship_date ] unless options[ :ship_date ].nil?
        shipment.ship_method = options[ :ship_method ] unless options[ :ship_method ].nil?
        shipment.tracking_number = options[ :tracking_number ] unless options[ :tracking_number ].nil?
      end
      
      def update_receipt( shipment, options )
        shipment.receipt_date = options[ :receipt_date ] unless options[ :receipt_date ].nil?
      end
      
      def clear_payment( shipment, options )
        unless options[ :clear_payment ].nil?
          shipment.payment_date = nil
          shipment.ship_date = nil
          shipment.ship_method = nil
          shipment.tracking_number = nil
          shipment.receipt_date = nil
        end
      end
      
      def clear_shipping( shipment, options )
        unless options[ :clear_shipping ].nil?
          shipment.ship_date = nil
          shipment.ship_method = nil
          shipment.tracking_number = nil
          shipment.receipt_date = nil
        end
      end
      
      def clear_receipt( shipment, options )
        unless options[ :clear_receipt ].nil?
          shipment.receipt_date = nil
        end
      end
    
  end
  
end
