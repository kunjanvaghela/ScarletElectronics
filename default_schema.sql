
/*Db Scripts*/

create schema ScarletElectronics;
use ScarletElectronics;

/*Users Table:*/
CREATE TABLE `users` (
    `userId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `encrypted_name` VARCHAR(1024) NOT NULL,
    `emailId` VARCHAR(50) NOT NULL,
    `encrypted_emailId` VARCHAR(1024) NOT NULL,
    `password` VARCHAR(30) NOT NULL,
    `encrypted_password` VARCHAR(1024) NOT NULL,
    `created_by` VARCHAR(20) DEFAULT NULL,
    `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `remarks` VARCHAR(100) DEFAULT NULL,
    `status` VARCHAR(1) DEFAULT NULL,
    `updated_by` VARCHAR(20) DEFAULT NULL,
    `updated_on` DATETIME DEFAULT NULL,
    PRIMARY KEY (`userId`),
    UNIQUE KEY `emailId` (`emailId`)
); 

CREATE TABLE `staff` (
  `userId` int unsigned NOT NULL,
  `ssn` int DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `designation` varchar(10) DEFAULT NULL,
  `status` varchar(1) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) DEFAULT NULL,
  `remarks` varchar(100) DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  PRIMARY KEY (`userId`)
  -- Seperate end user and staff tables
  -- CONSTRAINT `ref_staff_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE
);

/*Item Master Table*/
CREATE TABLE `ref_catalog` (
  `itemId` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(350) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `cpu` varchar(350) DEFAULT NULL,
  `gpu` varchar(350) DEFAULT NULL,
  `ram` varchar(350) DEFAULT NULL,
  `storage` varchar(350) DEFAULT NULL,
  `operating_system` varchar(350) DEFAULT NULL,
  `screen_size` varchar(350) DEFAULT NULL,
  `screen_type` varchar(350) DEFAULT NULL,
  `screen_resolution` varchar(350) DEFAULT NULL,
  `front_camera` varchar(350) DEFAULT NULL,
  `rear_camera` varchar(350) DEFAULT NULL,
  `itemImage` longblob,
  `listing_Status` varchar(10) DEFAULT NULL,
  `approval_Status` varchar(10) DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `remarks` varchar(350) DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  PRIMARY KEY (`itemId`)
);

CREATE TABLE `end_user` (
  `userId` int unsigned NOT NULL,
  `address_line1` varchar(50) DEFAULT NULL,
  `address_line2` varchar(50) DEFAULT NULL,
  `address_city` varchar(50) DEFAULT NULL,
  `address_state_code` varchar(2) DEFAULT NULL,
  `address_zipcode` varchar(6) DEFAULT NULL,
  `phone_nr` varchar(15) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `end_users_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE
); 

/*Item Listing Table, storing all items for sale by seller at different prices:*/
CREATE TABLE `item_listing` (
  `listingId` int unsigned NOT NULL AUTO_INCREMENT,
  `itemId` int unsigned NOT NULL,
  `sellerId` int unsigned NOT NULL,
  `price` float NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) DEFAULT NULL,
  `remarks` varchar(100) DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `quantity` int unsigned DEFAULT 0,
  PRIMARY KEY (`listingId`),
  KEY `sellerId` (`sellerId`),
  KEY `itemId` (`itemId`),
  CONSTRAINT `item_listing_ibfk_1` FOREIGN KEY (`sellerId`) REFERENCES `end_user` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `item_listing_ibfk_2` FOREIGN KEY (`itemId`) REFERENCES `ref_catalog` (`itemId`) ON DELETE CASCADE,
  CHECK (`quantity` >= 0),
  CHECK (`price` >= 0)
);

/*Support Request Table:*/
CREATE TABLE `end_user_request` (
  `requestId` int unsigned NOT NULL AUTO_INCREMENT,
  `userId` int unsigned NOT NULL,
  `listingId` int unsigned DEFAULT NULL,
  `update_description` varchar(200) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `current_status` varchar(5) DEFAULT NULL,
  `customer_rep` int unsigned DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  PRIMARY KEY (`requestId`),
  KEY `userId` (`userId`),
  KEY `listingId` (`listingId`),
  CONSTRAINT `enduserrequests_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `end_user` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `enduserrequests_ibfk_2` FOREIGN KEY (`listingId`) REFERENCES `item_listing` (`listingId`) ON DELETE CASCADE
  -- No need to create a foriegn key for staff table as only customer rep can access this
  /*CONSTRAINT `enduserrequests_ibfk_3` FOREIGN KEY (`customer_rep`) REFERENCES `staff` (`userId`) ON DELETE CASCADE*/
);

-- CREATE TABLE `frequentlyaskedquestions` (
--   `faqid` int unsigned NOT NULL AUTO_INCREMENT,
--   `question` varchar(200) DEFAULT NULL,
--   `answer` varchar(200) DEFAULT NULL,
--   `userId` int unsigned NOT NULL,
--   `statusFAQ` varchar(10) DEFAULT NULL,
--   PRIMARY KEY (`faqid`),
--   KEY `userId` (`userId`),
--   CONSTRAINT `frequentlyaskedquestions_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users__` (`userId`) ON DELETE CASCADE
-- );

/* Cart table */
create table cart(
	cartId int NOT NULL auto_increment,
    listingId int unsigned NOT NULL,
    userId int unsigned NOT NULL,
    quantity int NOT NULL,
    PRIMARY KEY(cartId),
    FOREIGN KEY (`userId`) REFERENCES `end_user` (`userId`),
    FOREIGN KEY (`listingId`) REFERENCES `item_listing` (`listingId`) ON DELETE CASCADE
);

/* Payment table storing the payment method a user has */
create table payment(
	paymentId int NOT NULL auto_increment Primary key,
    userId int unsigned NOT NULL,
    name_on_card varchar(30) NOT NULL,
	business_address_line1 varchar(50) DEFAULT NULL,
    business_address_line2 varchar(50) DEFAULT NULL,
    business_address_city varchar(50) DEFAULT NULL,
    business_address_state_code varchar(2) DEFAULT NULL,
    business_address_zipcode varchar(6) DEFAULT NULL,
    card_number varchar(128) NOT NULL,
    FOREIGN KEY (`userId`) REFERENCES `end_user` (`userId`)
);

/* Purchase table storing the purchaseHistory of user*/
create table purchase(
	purchaseId int NOT NULL auto_increment Primary key,
    purchase_date timestamp NOT NULL,
    paymentId int NOT NULL,
    total_price float NOT NULL,
    FOREIGN KEY (`paymentId`) REFERENCES `payment` (`paymentId`)
);

/* DeliveryInfo table stores the delivery details per pruchase*/
create table delivery_info(
	deliveryId int NOT NULL auto_increment Primary key,
    purchaseId int NOT NULL,
    estimated_delivery_date timestamp,
    actual_delivery_date timestamp,
	delivery_address_line1 varchar(50) DEFAULT NULL,
    delivery_address_line2 varchar(50) DEFAULT NULL,
    delivery_address_city varchar(50) DEFAULT NULL,
    delivery_address_state_code varchar(2) DEFAULT NULL,
    delivery_address_zipcode varchar(6) DEFAULT NULL,
    FOREIGN KEY (`purchaseId`) REFERENCES `purchase` (`purchaseId`)
);

/* OrderDetail table stores the items ordered per purchase*/
create table order_detail(
	orderId int NOT NULL auto_increment,
    listingId int unsigned NOT NULL,
    purchaseId int NOT NULL,
    quantity int NOT NULL,
    PRIMARY KEY(orderId),
    FOREIGN KEY (`listingId`) REFERENCES `item_listing` (`listingId`) ON DELETE CASCADE
);


/* Review table stores the review of the item by user*/
create table review(
	reviewId int NOT NULL auto_increment primary key,
    userId int unsigned NOT NULL,
    itemId int unsigned NOT NULL,
    rating enum('1','2','3','4','5') NOT NULL,
    comments varchar(256),
    FOREIGN KEY (`userId`) REFERENCES `end_user` (`userId`),
    FOREIGN KEY (`itemId`) REFERENCES `ref_catalog` (`itemId`)
);

/* Favourite table stores the review of the item by user*/
create table favourite(
	favouriteId int NOT NULL auto_increment primary key,
    userId int unsigned NOT NULL,
    itemId int unsigned NOT NULL,
    FOREIGN KEY (`userId`) REFERENCES `end_user` (`userId`),
    FOREIGN KEY (`itemId`) REFERENCES `ref_catalog` (`itemId`)    
);

create table tax_and_delivery_table(
	statecode varchar(2),
    tax_percent int unsigned NOT NULL,
	deliveryFee int unsigned NOT NULL,
    is_active bit NOT NULL
);

create table promocode(
	promocode varchar(15) NOT NULL primary key,
    discount_percent int unsigned,
	max_discount int NOT NULL,
    is_active bit NOT NULL
);

drop schema ScarletElectronics;
