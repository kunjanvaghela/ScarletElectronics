/*Db Scripts*/
create schema ScarletElectronics;
use ScarletElectronics;

/*Item Table*/
CREATE TABLE `catalog_master` (
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
  `addinfo1` varchar(350) DEFAULT NULL,
  `addinfo2` varchar(350) DEFAULT NULL,
  `addinfo3` varchar(350) DEFAULT NULL,
  `addinfo4` varchar(350) DEFAULT NULL,
  `addinfo5` bigint DEFAULT NULL,
  `addinfo6` tinyint(1) DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `remarks` varchar(350) DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  PRIMARY KEY (`itemId`)
);

/*Users Table:*/

CREATE TABLE `users__` (
  `userId` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `encrypted_name` varchar(30) NOT NULL,
  `emailId` varchar(50) NOT NULL,
  `encrypted_emailId` varchar(256) NOT NULL,
  `password` varchar(30) NOT NULL,
  `encrypted_password` varchar(256) NOT NULL,
  `Add_info1` int DEFAULT NULL,
  `Add_info2` int DEFAULT NULL,
  `Add_info3` varchar(50) DEFAULT NULL,
  `Add_info4` varchar(50) DEFAULT NULL,
  `Created_by` varchar(20) DEFAULT NULL,
  `created_On` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `remarks` varchar(100) DEFAULT NULL,
  `status` varchar(1) DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `emailId` (`emailId`)
); 

CREATE TABLE `employeeprofilemaster` (
  `userId` int unsigned NOT NULL,
  `SSN` int DEFAULT NULL,
  `Dateofbirth` date DEFAULT NULL,
  `Designation` varchar(10) DEFAULT NULL,
  `Status` varchar(1) DEFAULT NULL,
  `createdOn` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Add_info1` int DEFAULT NULL,
  `Add_info2` int DEFAULT NULL,
  `Add_info3` varchar(50) DEFAULT NULL,
  `Add_info4` varchar(50) DEFAULT NULL,
  `Created_by` varchar(20) DEFAULT NULL,
  `remarks` varchar(100) DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `employeeprofilemaster_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users__` (`userId`) ON DELETE CASCADE
);

CREATE TABLE `endusers` (
  `userId` int unsigned NOT NULL,
  `address` varchar(50) DEFAULT NULL,
  `phoneNr` varchar(15) DEFAULT NULL,
  `createdBy` int DEFAULT NULL,
  `createdOn` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedBy` int DEFAULT NULL,
  `updatedOn` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `endusers_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users__` (`userId`) ON DELETE CASCADE
); 

/*Item Listing Table:*/

CREATE TABLE `item_listing` (
  `listingId` int unsigned NOT NULL AUTO_INCREMENT,
  `itemId` int unsigned NOT NULL,
  `sellerId` int unsigned NOT NULL,
  `price` float NOT NULL,
  `createdOn` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Created_by` varchar(20) DEFAULT NULL,
  `remarks` varchar(100) DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`listingId`),
  KEY `sellerId` (`sellerId`),
  KEY `itemId` (`itemId`),
  CONSTRAINT `item_listing_ibfk_1` FOREIGN KEY (`sellerId`) REFERENCES `endusers` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `item_listing_ibfk_2` FOREIGN KEY (`itemId`) REFERENCES `catalog_master` (`itemId`) ON DELETE CASCADE
);

/*Support Request Table:*/
CREATE TABLE `enduserrequests` (
  `requestid` int unsigned NOT NULL AUTO_INCREMENT,
  `userId` int unsigned NOT NULL,
  /*`listingId` int unsigned DEFAULT NULL,*/
  `update_description` varchar(200) DEFAULT NULL,
  `current_status` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`requestid`),
  KEY `userId` (`userId`),
  -- KEY `listingId` (`listingId`),
  CONSTRAINT `enduserrequests_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `endusers` (`userId`) ON DELETE CASCADE
  -- CONSTRAINT `enduserrequests_ibfk_3` FOREIGN KEY (`listingId`) REFERENCES `item_listing` (`listingId`) ON DELETE CASCADE
);

CREATE TABLE `frequentlyaskedquestions` (
  `faqid` int unsigned NOT NULL AUTO_INCREMENT,
  `question` varchar(200) DEFAULT NULL,
  `answer` varchar(200) DEFAULT NULL,
  `userId` int unsigned NOT NULL,
  `statusFAQ` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`faqid`),
  KEY `userId` (`userId`),
  CONSTRAINT `frequentlyaskedquestions_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users__` (`userId`) ON DELETE CASCADE
);

create table cart(
	cartID int NOT NULL auto_increment,
    listingID int unsigned NOT NULL,
    userID int unsigned NOT NULL,
    quantity int NOT NULL,
    PRIMARY KEY(cartID),
    FOREIGN KEY (`userId`) REFERENCES `users__` (`userId`),
    FOREIGN KEY (`listingId`) REFERENCES `item_listing` (`listingId`) ON DELETE CASCADE
);

create table payment(
	paymentID int NOT NULL auto_increment Primary key,
    userID int unsigned NOT NULL,
    nameOnCard varchar(30) NOT NULL,
    billingAddress varchar(128) NOT NULL,
    cardNumber varchar(128) NOT NULL,
    FOREIGN KEY (`userId`) REFERENCES `users__` (`userId`)
);

create table purchase(
	purchaseID int NOT NULL auto_increment Primary key,
    purchaseDate timestamp NOT NULL,
    paymentID int NOT NULL,
    FOREIGN KEY (`paymentID`) REFERENCES `payment` (`paymentID`)
);

create table deliveryInfo(
	deliveryID int NOT NULL auto_increment Primary key,
    purchaseID int NOT NULL,
    estimatedDeliveryDate timestamp,
    actualDeliveryDate timestamp,
    FOREIGN KEY (`purchaseID`) REFERENCES `purchase` (`purchaseID`)
);

create table orderDetails(
	orderID int NOT NULL auto_increment,
    listingID int unsigned NOT NULL,
    paymentID int NOT NULL,
    purchaseID int NOT NULL,
    quantity int NOT NULL,
    PRIMARY KEY(orderID),
    FOREIGN KEY (`paymentID`) REFERENCES `payment` (`paymentID`),
    FOREIGN KEY (`listingId`) REFERENCES `item_listing` (`listingId`) ON DELETE CASCADE
);

create table reviews(
	reviewID int NOT NULL auto_increment primary key,
    userID int unsigned NOT NULL,
    itemID int NOT NULL,
    rating enum('1','2','3','4','5') NOT NULL,
    comments varchar(256),
    FOREIGN KEY (`userId`) REFERENCES `users__` (`userId`),
    FOREIGN KEY (`itemId`) REFERENCES `catalog_master` (`itemId`)
);

create table favourite(
	favouriteID int NOT NULL auto_increment primary key,
    userID int unsigned NOT NULL,
    itemID int unsigned NOT NULL,
    FOREIGN KEY (`userId`) REFERENCES `users__` (`userId`),
    FOREIGN KEY (`itemId`) REFERENCES `catalog_master` (`itemId`)    
);



-- drop table catalog_master;
-- drop database scarletelectronics;
