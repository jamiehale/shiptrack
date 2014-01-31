require 'spec_helper.rb'

module ShipTrack
  
  describe Shipment do
    
    describe 'default constructor' do
      
      before( :each ) do
        @shipment = Shipment.new
      end
      
      it 'has no name' do
        @shipment.name.should be_nil
      end
      
      it 'has no vendor' do
        @shipment.vendor.should be_nil
      end
      
      it 'has no order_date' do
        @shipment.order_date.should be_nil
      end
      
      it 'has no purchase_date' do
        @shipment.purchase_date.should be_nil
      end
      
      it 'has no ship_date' do
        @shipment.ship_date.should be_nil
      end
      
      it 'has no ship_method' do
        @shipment.ship_method.should be_nil
      end
      
      it 'has no tracking_number' do
        @shipment.ship_tracking_number.should be_nil
      end
      
      it 'has no receive_date' do
        @shipment.receive_date.should be_nil
      end
    
    end
    
    describe 'constructor from hash' do

      before( :each ) do
        @shipment = Shipment.new(
          {
            :name => 'Something',
            :vendor => 'Somebody',
            :order_date => '2014-01-01',
            :purchase_date => '2014-01-02',
            :ship_date => '2014-01-03',
            :ship_method => 'UPS',
            :ship_tracking_number => '12345',
            :receive_date => '2014-01-04'
          }
        )
      end
      
      it 'has a name' do
        @shipment.name.should == 'Something'
      end
      
      it 'has a vendor' do
        @shipment.vendor.should == 'Somebody'
      end
      
      it 'has an order_date' do
        @shipment.order_date.should == '2014-01-01'
      end
      
      it 'has a purchase_date' do
        @shipment.purchase_date.should == '2014-01-02'
      end
      
      it 'has a ship_date' do
        @shipment.ship_date.should == '2014-01-03'
      end
      
      it 'has a ship_method' do
        @shipment.ship_method.should == 'UPS'
      end
      
      it 'has a ship_tracking_number' do
        @shipment.ship_tracking_number.should == '12345'
      end
      
      it 'has a receive_date' do
        @shipment.receive_date.should == '2014-01-04'
      end
      
      describe 'to_hash' do

        before( :each ) do
          @hash = @shipment.to_hash
        end
        
        it 'is a hash' do
          @hash.class.name == 'Hash'
        end
        
        it 'has a name key' do
          @hash[ :name ].should == 'Something'
        end
        
        it 'has a vendor key' do
          @hash[ :vendor ].should == 'Somebody'
        end
        
        it 'has an order_date key' do
          @hash[ :order_date ].should == '2014-01-01'
        end
        
        it 'has a purchase_date key' do
          @hash[ :purchase_date ].should == '2014-01-02'
        end
        
        it 'has a ship_date key' do
          @hash[ :ship_date ].should == '2014-01-03'
        end
        
        it 'has a ship_method key' do
          @hash[ :ship_method ].should == 'UPS'
        end
        
        it 'has a ship_tracking_number key' do
          @hash[ :ship_tracking_number ].should == '12345'
        end
        
        it 'has a receive_date key' do
          @hash[ :receive_date ].should == '2014-01-04'
        end
        
      end

    end
    
    describe 'states' do
      
      it 'defaults to UNKNOWN' do
        Shipment.new.state.should == 'UNKNOWN'
      end
      
      describe 'with an order_date and no other dates' do
        
        before( :each ) do
          @shipment = Shipment.new( { :order_date => '2014-01-01' } )
        end
      
        it 'has ORDERED state' do
          @shipment.state.should == 'ORDERED'
        end
        
        it 'is ordered?' do
          @shipment.should be_ordered
        end
        
      end
      
      describe 'with a purchase_date and order_date and no other dates' do
        
        before( :each ) do
          @shipment = Shipment.new( { :order_date => '2014-01-01', :purchase_date => '2014-01-02' } )
        end
      
        it 'has PAID state' do
          @shipment.state.should == 'PAID'
        end
        
        it 'is paid?' do
          @shipment.should be_paid
        end
        
      end
      
      describe 'with a ship_date, purchase_date, and order_date and no other dates' do
        
        before( :each ) do
          @shipment = Shipment.new( { :order_date => '2014-01-01', :purchase_date => '2014-01-02', :ship_date => '2014-01-03' } )
        end
      
        it 'has SHIPPED state' do
          @shipment.state.should == 'SHIPPED'
        end
        
        it 'is shipped?' do
          @shipment.should be_shipped
        end
        
      end
      
      describe 'with a received_date, ship_date, purchase_date, and order_date and no other dates' do
        
        before( :each ) do
          @shipment = Shipment.new( { :order_date => '2014-01-01', :purchase_date => '2014-01-02', :ship_date => '2014-01-03', :receive_date => '2014-01-04' } )
        end
        
        it 'has RECEIVED state' do
          @shipment.state.should == 'RECEIVED'
        end
        
        it 'is received?' do
          @shipment.should be_received
        end
        
      end
      
    end

    describe 'automatically setting dates' do
      
      let( :shipment ) { Shipment.new }

      describe 'purchasing' do

        before( :each ) do
          shipment.purchase_date = '2014-01-01'
        end
        
        it 'sets purchase date' do
          shipment.purchase_date.should == '2014-01-01'
        end
        
        it 'sets order date too' do
          shipment.order_date.should == '2014-01-01'
        end
        
        describe 'already ordered' do
          
          let( :shipment ) { Shipment.new( { :order_date => '2013-12-01' } ) }
          
          it 'does not overwrite the order date' do
            expect( shipment.order_date ).to eq '2013-12-01'
          end
          
        end
        
      end
      
      describe 'shipping' do
        
        before( :each ) do
          shipment.ship_date = '2014-01-02'
        end
        
        it 'sets ship_date' do
          shipment.ship_date.should == '2014-01-02'
        end
        
        it 'sets purchase_date too' do
          shipment.purchase_date.should == '2014-01-02'
        end
        
        it 'sets order_date too' do
          shipment.order_date.should == '2014-01-02'
        end
        
        describe 'already purchased' do
          
          let( :shipment ) { Shipment.new( { :purchase_date => '2013-12-01' } ) }
          
          it 'does not overwrite the purchase date' do
            expect( shipment.purchase_date ).to eq '2013-12-01'
          end
          
        end
        
        describe 'already ordered' do

          let( :shipment ) { Shipment.new( { :order_date => '2013-12-01' } ) }
          
          it 'does not overwrite the order date' do
            expect( shipment.order_date ).to eq '2013-12-01'
          end
          
        end
        
      end
      
      describe 'receiving' do
        
        before( :each ) do
          shipment.receive_date = '2014-01-03'
        end
      
        it 'sets receive_date' do
          shipment.receive_date.should == '2014-01-03'
        end
        
        it 'sets ship_date too' do
          shipment.ship_date.should == '2014-01-03'
        end

        it 'sets purchase_date too' do
          shipment.purchase_date.should == '2014-01-03'
        end

        it 'sets order_date too' do
          shipment.order_date.should == '2014-01-03'
        end
        
        describe 'already shipped' do
          
          let( :shipment ) { Shipment.new( { :ship_date => '2013-12-01' } ) }
          
          it 'does not overwrite the ship date' do
            expect( shipment.ship_date ).to eq '2013-12-01'
          end
          
        end
        
        describe 'already purchased' do
          
          let( :shipment ) { Shipment.new( { :purchase_date => '2013-12-01' } ) }
          
          it 'does not overwrite the purchase date' do
            expect( shipment.purchase_date ).to eq '2013-12-01'
          end
          
        end
        
        describe 'already ordered' do

          let( :shipment ) { Shipment.new( { :order_date => '2013-12-01' } ) }
          
          it 'does not overwrite the order date' do
            expect( shipment.order_date ).to eq '2013-12-01'
          end
          
        end

      end
      
    end
    
  end
  
end
