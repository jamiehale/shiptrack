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
