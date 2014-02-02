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

require 'spec_helper.rb'

module ShipTrack
  
  describe Configuration do
    
    describe 'construction' do
      
      let( :configuration_file ) { double( 'configuration_file' ) }
      
      before( :each ) do
        configuration_file.stub( :each ).and_yield( :name, 'value' )
      end
    
      it 'sets parameters in constructor' do
        configuration = Configuration.new( configuration_file )
        expect( configuration[ :name ] ).to eq( 'value' )
      end
    
      it 'sets parameters through []' do
        configuration = Configuration.new( {} )
        configuration[ :name ] = 'value'
        expect( configuration[ :name ] ).to eq( 'value' )
      end
      
    end
    
  end
  
end
