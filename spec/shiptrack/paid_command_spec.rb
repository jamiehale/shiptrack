require 'spec_helper.rb'

module ShipTrack
  
  describe PaidCommand do
    
    let( :command ) { PaidCommand.new }
    
    it 'has a name' do
      expect( command.name ).to eq 'paid'
    end
    
    it 'has a description' do
      expect( command.description ).to_not be_nil
    end
    
    it 'handles the parameter set [index,int]' do
      expect( command.parameter_sets ).to include [ CommandParameter.new( :index, :int ) ]
    end
    
    it 'only handles 1 parameter set' do
      expect( command.parameter_sets.size ).to eq 1
    end
    
    it 'handles a date option' do
      expect( command.options ).to include CommandOption.new( :date, :string )
    end
    
  end
  
end
