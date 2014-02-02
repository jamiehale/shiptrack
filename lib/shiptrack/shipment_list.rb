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
  
  class ShipmentList
    
    def initialize( shipments = [] )
      @shipments = shipments
    end
    
    def count
      @shipments.size
    end
    
    def empty?
      @shipments.empty?
    end
    
    def add( shipment )
      @shipments << shipment
    end
    
    def delete( index )
      @shipments.delete_at( index )
    end
    
    def to_yaml
      @shipments.map{ |s| s.to_hash }.to_yaml
    end
    
    def each
      i = 0
      @shipments.each do |s|
        yield i, s
        i += 1
      end
    end
    
    def get_by_index( index )
      @shipments[ index ]
    end
    
    def self.load( filename )
      shipments = YAML.load_file( filename )
      ShipmentList.new( shipments.map { |s| Shipment.new( s ) } )
    end
    
    def save( filename )
      File.open( filename, 'w' ) do |f|
        f.write( to_yaml )
      end
    end
    
  end
  
end
