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
  
  class ListCommand < Command
    
    include FileUtils

    def initialize( dumper )
      super( 'list' )
      describe 'Lists shipments and states'
      handle_no_parameters
      handle_option CommandOption.new( :ordered, :flag )
      handle_option CommandOption.new( :paid, :flag )
      handle_option CommandOption.new( :shipped, :flag )
      handle_option CommandOption.new( :received, :flag )
      @dumper = dumper
    end

    def run( parameters, configuration, options )
      all_shipments = ShipmentList.load( configuration[ :active_shipments_filepath ] )
      all_shipments.each do |i,s|
        if selected?( s, options )
          @dumper.dump_list_line( i + 1, s )
        end
      end
    end
    
    private
    
      def options_set?( options )
        options[ :ordered ] or options[ :paid ] or options[ :shipped ] or options[ :received ]
      end
      
      def selected?( shipment, options )
        return true unless options_set?( options )
        return true if options[ :ordered ] and shipment.state == 'ORDERED'
        return true if options[ :paid ] and shipment.state == 'PAID'
        return true if options[ :shipped ] and shipment.state == 'SHIPPED'
        return true if options[ :received ] and shipment.state == 'RECEIVED'
        false
      end
    
  end
  
end
