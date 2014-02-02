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
  
  describe VersionCommand do
    
    describe '.initialize' do
      
      let( :command ) { VersionCommand.new }
    
      it 'has a name' do
        expect( command.name ).to eq 'version'
      end
    
      it 'has a description' do
        expect( command.description ).to_not be_nil
      end
    
      it 'handles the empty parameter set' do
        expect( command.parameter_sets ).to include []
      end
    
      it 'only handles 1 parameter set' do
        expect( command.parameter_sets.size ).to eq 1
      end
    
      it 'handles no options' do
        expect( command.options ).to be_empty
      end
      
    end
    
    describe '#run' do
      
      let( :command ) { VersionCommand.new }
      
      it 'dumps the version' do
        $stdout.stub( :puts )
        $stdout.should_receive( :puts )
        command.run( {}, nil, {} )
      end
      
    end
    
  end
  
end
