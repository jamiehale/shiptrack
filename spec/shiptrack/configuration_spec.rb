require 'spec_helper.rb'

module ShipTrack
  
  describe Configuration do
    
    it 'sets parameters in constructor' do
      configuration = Configuration.new( { 'path' => 'some/path' } )
      expect( configuration[ 'path' ] ).to eq 'some/path'
    end
    
    it 'sets parameters through []' do
      configuration = Configuration.new( {} )
      configuration[ 'path' ] = 'another/path'
      expect( configuration[ 'path' ] ).to eq 'another/path'
    end
    
  end
  
end
