module ShipTrack
  
  class ArchiveCommand < Command
    
    include FileUtils
    
    def initialize
      super( 'archive' )
      describe 'Archives received shipments'
      handle_no_parameters
    end
    
    def run( params, configuration, options )
      all_shipments = ShipmentList.load( configuration[ :active_shipments_filepath ] )
      to_archive = []
      all_shipments.each do |i,s|
        if s.state == 'RECEIVED'
          to_archive << [ i, s ]
        end
      end
      mkdir configuration[ :archive_path ] unless File.directory?( configuration[ :archive_path ] )
      ShipmentList.new().save( configuration[ :active_archive_filepath ] ) unless File.exists?( configuration[ :active_archive_filepath ] )
      archive_shipments = ShipmentList.load( configuration[ :active_archive_filepath ] )
      to_archive.each do |i,s|
        archive_shipments.add( s )
      end
      archive_shipments.save( configuration[ :active_archive_filepath ] )
      to_archive.reverse.each do |i,s|
        all_shipments.delete( i )
      end
      all_shipments.save( configuration[ :active_shipments_filepath ] )
    end
    
    private
    
  end
  
end
