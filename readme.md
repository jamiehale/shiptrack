shiptrack
=========

This is a goofy little utility to help me track online purchases and shipments. Use it to record things you buy when you buy them, then update them as things ship. Query for things you're still waiting to receive. Launch web-based tracking for several major couriers.

*shiptrack* requires Ruby 2.

Record List
===========

*shiptrack* commands often work on the current record list. View the record list with the *list* command.

    $ shiptrack list
    1: A bag of rocks [ORDERED]
    2: A spleen (from eBay) [PAID]
    3: Clacky keyboard (from Matias) [SHIPPED]
    4: Chickens (from Craig's List) [RECEIVED]

Flow
====

The flow is as follows:

1. Ordered
2. Purchased (paid for)
3. Shipped
4. Received
5. Archived

Record something to be tracked using the *order* or *purchase* commands. This starts the record in the Ordered or Purchased state respectively.

    $ shiptrack order "A bag of rocks"
    $ shiptrack purchase "A spleen" --vendor "eBay" --date "2014-03-24"

Move a record from Ordered to Purchased with the *paid* command using the record list index.

    $ shiptrack paid 3

Move a record from Purchased to Shipped with the *ship* command.

    $ shiptrack ship 4 --method FedEx --tracking-number 12345

Launch a web browser to track a shipment using the recorded tracking information with the *track* command.

    $ shiptrack track 4

Move a record from Shipped to Received with the *receive* command.

    $ shiptrack receive 4

Move all Received records into the archive with the *archive* command.

    $ shiptrack archive

Update records with the *update* command.

    $ shiptrack update 3 --ship-method "Canada Post"

Building
========

Build the gem using Rake.

    $ rake

*shiptrack* uses RSpec for testing.

    $ rake spec
