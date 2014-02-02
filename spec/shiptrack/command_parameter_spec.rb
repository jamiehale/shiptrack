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
  
  describe CommandParameter do
    
    describe 'constructor' do
      
      let( :parameter ) { CommandParameter.new( :index, :int ) }
      
      it 'has a name' do
        expect( parameter.name ).to eq :index
      end
      
      it 'has a type' do
        expect( parameter.type ).to eq :int
      end
      
    end
    
    describe '==' do
      
      it 'handles equality' do
        expect( CommandParameter.new( :index, :int ) ).to eq CommandParameter.new( :index, :int )
      end
      
    end
    
  end
  
end
