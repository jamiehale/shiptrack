require 'spec_helper.rb'

module ShipTrack
  
  describe ConfigurationFile do

    it 'builds defaults to empty' do
      configuration_file = ConfigurationFile.new
      expect( configuration_file ).to be_empty
    end
    
    it 'builds from a hash' do
      configuration_file = ConfigurationFile.new( { 'path' => 'some/path' } )
      expect( configuration_file ).to_not be_empty
    end

    it 'converts string keys to symbols on creation' do
      configuration_file = ConfigurationFile.new( { 'path' => 'some/path' } )
      expect( configuration_file[ :path ] ).to eq( 'some/path' )
    end
    
    it 'converts string keys to symbols on setting' do
      configuration_file = ConfigurationFile.new
      configuration_file[ 'path' ] = 'some/path'
      expect( configuration_file[ :path ] ).to eq( 'some/path' )
    end
    
    describe 'loading' do

      describe 'when the file exists' do
        
        let( :yaml ) { {} }
        let( :configuration_file ) { double( 'configuration_file' ) }

        before( :each ) do
          YAML.stub( :load_file ).and_return( yaml )
          File.stub( :exists? ).and_return( true )
          ConfigurationFile.stub( :new ).and_return( configuration_file )
        end
        
        it 'defers to YAML for loading' do
          YAML.should_receive( :load_file ).with( 'some/file' )
          ConfigurationFile.load( 'some/file' )
        end
      
        it 'creates a new ConfigurationFile from the YAML' do
          ConfigurationFile.should_receive( :new ).with( yaml )
          ConfigurationFile.load( 'some/file' )
        end
      
        it 'returns the new configuration file' do
          new_configuration_file = ConfigurationFile.load( 'some/file' )
          expect( new_configuration_file ).to eq( configuration_file )
        end
        
      end
      
      describe 'when the file does not exist' do

        let( :configuration_file ) { double( 'configuration_file' ) }
        
        before( :each ) do
          File.stub( :exists? ).and_return( false )
          ConfigurationFile.stub( :new ).and_return( configuration_file )
          configuration_file.stub( :save )
        end
        
        it 'creates a new ConfigurationFile from defaults' do
          ConfigurationFile.should_receive( :new ).with( ConfigurationFile.defaults ).and_return( configuration_file )
          ConfigurationFile.load( 'some/file' )
        end
        
        it 'writes the defaults out to the file' do
          configuration_file.should_receive( :save ).with( 'some/file' )
          ConfigurationFile.load( 'some/file' )
        end
        
        it 'returns the defaults' do
          result = ConfigurationFile.load( 'some/file' )
          expect( result ).to eq( configuration_file )
        end
        
      end

    end
    
    describe 'to_yaml' do
      
      let( :params ) { { 'path' => 'some/file', 'group' => [ 'first', 'second', 'third' ] } }
      let( :configuration_file ) { ConfigurationFile.new( params ) }
      let( :yaml ) { configuration_file.to_yaml }
      
      it 'converts key values' do
        expect( configuration_file.to_yaml ).to eq( params.to_yaml )
      end
      
    end
    
    describe 'saving' do

      let( :configuration_file ) { ConfigurationFile.new }
      let( :file ) { double( 'file' ) }
      
      before( :each ) do
        File.stub( :open ).and_yield( file )
        file.stub( :write )
      end
      
      it 'opens the file' do
        File.should_receive( :open ).with( 'some/file', 'w' )
        configuration_file.save( 'some/file' )
      end
      
      it 'writes the yaml' do
        file.should_receive( :write ).with( configuration_file.to_yaml )
        configuration_file.save( 'some/file' )
      end
      
    end
      
  end
  
end
