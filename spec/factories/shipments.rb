module ShipTrack
  
  FactoryGirl.define do
  
    factory :shipment, :class => Shipment do
      name 'Dungeons and Dragons books'
      vendor 'eBay'
      order_date '2014-01-01'
    end
  
    factory :ordered_shipment, :class => Shipment do
      name 'Dungeons and Dragons books'
      vendor 'eBay'
      order_date '2014-01-01'
    end
  
    factory :paid_shipment, :class => Shipment do
      name 'Dungeons and Dragons books'
      vendor 'eBay'
      order_date '2014-01-01'
      payment_date '2014-01-02'
    end
  
    factory :shipped_shipment, :class => Shipment do
      name 'Dungeons and Dragons books'
      vendor 'eBay'
      order_date '2014-01-01'
      payment_date '2014-01-02'
      ship_date '2014-01-03'
      ship_method 'UPS'
      tracking_number '12345'
    end
  
    factory :received_shipment, :class => Shipment do
      name 'Dungeons and Dragons books'
      vendor 'eBay'
      order_date '2014-01-01'
      payment_date '2014-01-02'
      ship_date '2014-01-03'
      ship_method 'UPS'
      tracking_number '12345'
      receipt_date '2014-01-04'
    end
  
  end

end
