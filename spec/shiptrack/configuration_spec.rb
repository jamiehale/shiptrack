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
