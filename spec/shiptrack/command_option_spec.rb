require 'spec_helper.rb'

module ShipTrack
  
  describe CommandOption do
    
    describe 'constructor' do
      
      let( :option ) { CommandOption.new( :date, :string ) }
      
      it 'has a name' do
        expect( option.name ).to eq :date
      end
      
      it 'has a type' do
        expect( option.type ).to eq :string
      end
      
    end
    
    describe '==' do
      
      it 'handles equality' do
        expect( CommandOption.new( :date, :string ) ).to eq CommandOption.new( :date, :string )
      end
      
    end
    
  end
  
end
