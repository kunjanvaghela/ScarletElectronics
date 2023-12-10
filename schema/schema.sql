SET SQL_MODE='ALLOW_INVALID_DATES';
SET storage_engine=INNODB;


use scarletelectronics;

drop table if EXISTS order_detail;
create table order_detail(
	orderId int NOT NULL auto_increment PRIMARY KEY,
    listingId int unsigned NOT NULL,
    purchaseId int NOT NULL,
    shipmentId varchar(50) NOT NULL,
    trackingId varchar(50),
    quantity int NOT NULL,
    total_cost_of_item float NOT NULL,
    order_status varchar(50) DEFAULT NULL,
    return_shipment varchar(50) DEFAULT NULL,
    trackingUrl varchar(150) NOT NULL,
    FOREIGN KEY (`purchaseId`) REFERENCES `purchase`(`purchaseId`) ON DELETE CASCADE,
    FOREIGN KEY (`listingId`) REFERENCES `item_listing`(`listingId`) ON DELETE CASCADE
);

