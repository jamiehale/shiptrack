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
  
  class DetailsCommand < Command
    
    def initialize( dumper )
      super( 'details' )
      describe 'Shows shipment details'
      handle_parameters [ CommandParameter.new( :index, :int ) ]
      @dumper = dumper
    end
    
    def run( params, configuration, options )
      all_shipments = ShipmentList.load( configuration[ :active_shipments_filepath ] )
      @dumper.dump( all_shipments.get_by_index( params[ :index ] - 1 ) )
    end
    
  end
  
end
