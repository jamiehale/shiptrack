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
  
  class ArchiveCommand < Command
    
    include FileUtils
    
    def initialize
      super( 'archive' )
      describe 'Archives received shipments'
      handle_no_parameters
    end
    
    def run( params, configuration, options )
      all_shipments = ShipmentList.load( configuration[ :active_shipments_filepath ] )
      to_archive = []
      all_shipments.each do |i,s|
        if s.state == 'RECEIVED'
          to_archive << [ i, s ]
        end
      end
      mkdir configuration[ :archive_path ] unless File.directory?( configuration[ :archive_path ] )
      ShipmentList.new().save( configuration[ :active_archive_filepath ] ) unless File.exists?( configuration[ :active_archive_filepath ] )
      archive_shipments = ShipmentList.load( configuration[ :active_archive_filepath ] )
      to_archive.each do |i,s|
        archive_shipments.add( s )
      end
      archive_shipments.save( configuration[ :active_archive_filepath ] )
      to_archive.reverse.each do |i,s|
        all_shipments.delete( i )
      end
      all_shipments.save( configuration[ :active_shipments_filepath ] )
    end
    
    private
    
  end
  
end
