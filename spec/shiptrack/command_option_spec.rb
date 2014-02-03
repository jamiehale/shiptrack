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
  
  describe CommandOption do
    
    describe 'constructor' do
      
      let( :option ) { CommandOption.new( :date, :string, 'description' ) }
      
      it 'has a name' do
        expect( option.name ).to eq :date
      end
      
      it 'has a type' do
        expect( option.type ).to eq :string
      end
      
      it 'has a description' do
        expect( option.description ).to eq 'description'
      end
      
    end
    
    describe '==' do
      
      it 'handles equality' do
        expect( CommandOption.new( :date, :string, 'description' ) ).to eq CommandOption.new( :date, :string, 'description' )
      end
      
    end
    
  end
  
end
