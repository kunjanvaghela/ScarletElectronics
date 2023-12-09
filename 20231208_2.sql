CREATE DATABASE  IF NOT EXISTS `bjy4c3bfqe9mnlvfzpwb` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bjy4c3bfqe9mnlvfzpwb`;
-- MySQL dump 10.13  Distrib 8.0.30, for macos12 (x86_64)
--
-- Host: bjy4c3bfqe9mnlvfzpwb-mysql.services.clever-cloud.com    Database: bjy4c3bfqe9mnlvfzpwb
-- ------------------------------------------------------
-- Server version	8.0.22-13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'a05a675a-1414-11e9-9c82-cecd01b08c7e:1-491550428,
a38a16d0-767a-11eb-abe2-cecd029e558e:1-345199478';

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `cartId` int NOT NULL AUTO_INCREMENT,
  `listingId` int unsigned NOT NULL,
  `userId` int unsigned NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`cartId`),
  KEY `userId` (`userId`),
  KEY `listingId` (`listingId`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `end_user` (`userId`),
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`listingId`) REFERENCES `item_listing` (`listingId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (88,11,61,1),(89,14,61,1),(90,17,61,1);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `end_user`
--

DROP TABLE IF EXISTS `end_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `end_user`
--

LOCK TABLES `end_user` WRITE;
/*!40000 ALTER TABLE `end_user` DISABLE KEYS */;
INSERT INTO `end_user` VALUES (15,'asc','asca','as','OR','asfcaa','sdbv',NULL,'2023-11-02 05:41:36',NULL,NULL),(22,'10 Paul Robeson','5A','Phelps','CA','08901','1324539203',NULL,'2023-11-02 23:22:38',NULL,NULL),(23,'9 Snclas','nsclam','nkcas','AR','08901','123456789',NULL,'2023-11-03 05:03:42',NULL,NULL),(24,'10 Paul Robeson Blvd','APT-9N','New Brunswick','NJ','08901','8488228389',NULL,'2023-11-03 16:01:08',NULL,NULL),(25,'10 Pauly','Blvd','New Brunswick','NJ','08901','8481817457',NULL,'2023-11-03 17:04:09',NULL,NULL),(26,'Dummy','dummy','New Brunswick','AL','08901','12345678910',NULL,'2023-11-03 19:43:33',NULL,NULL),(27,'100, Third Street','College Ave','New Brunswick','AL','08901','234893216432',NULL,'2023-11-03 22:42:09',NULL,NULL),(28,'sndksndkmwkmd','snjdnsdnkdkw','kdnwkdkwmd','NJ','08901','8989888089',NULL,'2023-11-03 22:43:17',NULL,NULL),(29,'1 Richmond Street','Apt 1079','New Brunswick','AL','08901','17325226523',NULL,'2023-11-04 01:20:53',NULL,NULL),(30,'1 Richmond St. #1079, New Brunswick, NJ 08901','test','New Brunswick','NJ','08901','7325226783',NULL,'2023-11-04 02:19:10',NULL,NULL),(31,'1222','222','NB','NJ','08901','7324332229',NULL,'2023-11-18 19:08:02',NULL,NULL),(32,'9S riverside towers','paul road','New Brunswick','AL','12345','1234567890',NULL,'2023-11-18 22:39:41',NULL,NULL),(38,'60 aptereson','unit902','nb','NJ','08901','123654789',NULL,'2023-11-27 22:08:41',NULL,NULL),(40,'500 Revere Crossing Ln #208','est','Cary','NC','27519','9204427614',NULL,'2023-11-28 18:12:03',NULL,NULL),(59,'65 Dudley Rd.,',' ','New Brunswick','NJ','08904','732-456-7890',NULL,'2023-12-08 21:01:19',NULL,NULL),(61,'65 Dudley Rd',' ','New Brunswick','NJ','08904','7321234567',NULL,'2023-12-08 21:18:58',NULL,NULL),(67,'B - 18, Shri Hari Bunglows','Opposite Pa','Vadodara','AL','390019','8483139765',NULL,'2023-12-09 00:40:17',NULL,NULL);
/*!40000 ALTER TABLE `end_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `end_user_request`
--

DROP TABLE IF EXISTS `end_user_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
  CONSTRAINT `enduserrequests_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `end_user` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `end_user_request`
--

LOCK TABLES `end_user_request` WRITE;
/*!40000 ALTER TABLE `end_user_request` DISABLE KEYS */;
INSERT INTO `end_user_request` VALUES (1,23,NULL,'Hello world','2023-11-02 21:39:49','A',45,'2023-11-02 21:39:49'),(3,23,NULL,'Refund Requested','2023-11-02 21:39:49','A',37,'2023-11-02 21:39:49'),(4,25,NULL,'hello','2023-12-06 17:45:14','C',45,NULL),(5,25,NULL,'i am a disco dancer','2023-12-06 17:58:33','I',60,'2023-12-08 23:08:55'),(6,25,NULL,'i love ','2023-12-06 18:03:03','C',60,NULL),(7,25,NULL,'123456','2023-12-06 18:04:41','A',60,NULL),(8,25,NULL,'4567','2023-12-06 18:07:00','A',60,NULL),(9,25,NULL,'yuiop','2023-12-06 18:09:18','A',60,NULL),(10,25,NULL,'1wscder','2023-12-06 18:10:25','A',60,NULL),(11,25,NULL,'lllooolll','2023-12-06 18:11:47','A',60,NULL),(12,38,23,'Can I please get a refund for this?','2023-12-07 04:22:10','A',60,NULL),(13,38,56,'This is a defective product','2023-12-07 04:56:36','A',37,NULL),(14,38,58,'This product is unavailable','2023-12-07 05:44:35','A',37,NULL),(15,25,78,'nkhjjygakshgdfysvjcytsa','2023-12-07 21:15:07','A',60,NULL),(16,25,54,'issues','2023-12-07 22:13:07','A',37,NULL),(17,25,100,'problem','2023-12-09 01:42:50','A',NULL,'2023-12-09 01:42:50');
/*!40000 ALTER TABLE `end_user_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favourite`
--

DROP TABLE IF EXISTS `favourite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favourite` (
  `favouriteId` int NOT NULL AUTO_INCREMENT,
  `userId` int unsigned NOT NULL,
  `itemId` int unsigned NOT NULL,
  PRIMARY KEY (`favouriteId`),
  KEY `userId` (`userId`),
  KEY `itemId` (`itemId`),
  CONSTRAINT `favourite_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `end_user` (`userId`),
  CONSTRAINT `favourite_ibfk_2` FOREIGN KEY (`itemId`) REFERENCES `ref_catalog` (`itemId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favourite`
--

LOCK TABLES `favourite` WRITE;
/*!40000 ALTER TABLE `favourite` DISABLE KEYS */;
/*!40000 ALTER TABLE `favourite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_listing`
--

DROP TABLE IF EXISTS `item_listing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
  `quantity` int unsigned DEFAULT '0',
  `listing_status` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`listingId`),
  KEY `sellerId` (`sellerId`),
  KEY `itemId` (`itemId`),
  CONSTRAINT `item_listing_ibfk_1` FOREIGN KEY (`sellerId`) REFERENCES `end_user` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `item_listing_ibfk_2` FOREIGN KEY (`itemId`) REFERENCES `ref_catalog` (`itemId`) ON DELETE CASCADE,
  CONSTRAINT `item_listing_chk_1` CHECK ((`quantity` >= 0)),
  CONSTRAINT `item_listing_chk_2` CHECK ((`price` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_listing`
--

LOCK TABLES `item_listing` WRITE;
/*!40000 ALTER TABLE `item_listing` DISABLE KEYS */;
INSERT INTO `item_listing` VALUES (11,2,25,70.99,'2023-11-29 16:18:26','Madhura','success','sanchay','2023-12-07 23:57:43',5000,NULL),(12,45,25,1232,'2023-12-01 00:15:46',NULL,NULL,NULL,NULL,12,NULL),(13,46,25,432,'2023-12-01 00:23:57',NULL,NULL,NULL,NULL,21,NULL),(14,49,25,432,'2023-12-04 01:09:19','Madhura','great success','Madhura','2023-12-05 04:21:28',12,NULL),(17,61,25,499.99,'2023-12-07 20:02:00',NULL,NULL,NULL,NULL,54,NULL);
/*!40000 ALTER TABLE `item_listing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `messageId` int unsigned NOT NULL AUTO_INCREMENT,
  `requestId` int unsigned NOT NULL,
  `userId` int unsigned NOT NULL,
  `customer_rep` int unsigned DEFAULT NULL,
  `listingId` int unsigned DEFAULT NULL,
  `update_description` varchar(200) DEFAULT NULL,
  `created_on` datetime NOT NULL,
  `created_by` varchar(20) NOT NULL,
  PRIMARY KEY (`messageId`),
  KEY `requestId` (`requestId`),
  KEY `userId` (`userId`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`requestId`) REFERENCES `end_user_request` (`requestId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `end_user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,11,25,60,NULL,'lllooolll','2023-12-06 18:11:48','enduser'),(2,12,38,60,NULL,'Can I please get a refund for this?','2023-12-07 04:22:11','enduser'),(3,12,38,60,NULL,'tell me your product details?','2023-12-07 04:24:44','cr'),(4,13,38,NULL,NULL,'This is a defective product','2023-12-07 04:56:37','enduser'),(5,12,38,60,NULL,'Yes its samsung tablet','2023-12-07 04:59:52','cr'),(6,12,38,60,NULL,'hello??','2023-12-07 05:40:48','enduser'),(7,13,38,NULL,NULL,'hi any updates?','2023-12-07 05:42:55','enduser'),(8,14,38,NULL,58,'This product is unavailable','2023-12-07 05:44:36','enduser'),(9,14,38,37,NULL,'Can you tell me more about this product?','2023-12-07 05:46:59','cr'),(10,12,38,60,NULL,'your refund has been issued to your original payment method. I am closing this request now.','2023-12-07 06:24:57','cr'),(11,15,25,60,78,'nkhjjygakshgdfysvjcytsa','2023-12-07 21:15:07','enduser'),(12,15,25,60,NULL,'hello how may I help you?','2023-12-07 21:17:23','cr'),(13,15,25,60,NULL,'how do you do?','2023-12-07 21:18:00','cr'),(14,15,25,60,78,'thank you','2023-12-07 22:12:19','enduser'),(15,16,25,NULL,54,'issues','2023-12-07 22:13:07','enduser'),(16,16,25,37,NULL,'hi tell em your issue?','2023-12-07 23:46:23','cr'),(17,12,38,60,NULL,'ki haal chal?','2023-12-08 20:36:46','cr'),(18,17,25,NULL,100,'problem','2023-12-09 01:42:50','enduser');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_detail` (
  `orderId` int NOT NULL AUTO_INCREMENT,
  `listingId` int unsigned NOT NULL,
  `purchaseId` int NOT NULL,
  `quantity` int NOT NULL,
  `total_cost_of_item` float NOT NULL,
  `shipmentId` varchar(50) DEFAULT NULL,
  `trackingId` varchar(50) DEFAULT NULL,
  `order_status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`orderId`),
  KEY `listingId` (`listingId`),
  CONSTRAINT `order_detail_ibfk_1` FOREIGN KEY (`listingId`) REFERENCES `item_listing` (`listingId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `otps`
--

DROP TABLE IF EXISTS `otps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `otps` (
  `emailId` varchar(50) NOT NULL,
  `encrypted_emailId` varchar(1024) DEFAULT NULL,
  `otp` varchar(5) DEFAULT NULL,
  `encrypted_otp` varchar(1024) DEFAULT NULL,
  `created_on` datetime NOT NULL,
  `expires_on` datetime NOT NULL,
  PRIMARY KEY (`emailId`),
  UNIQUE KEY `emailId` (`emailId`),
  CONSTRAINT `otps_ibfk_1` FOREIGN KEY (`emailId`) REFERENCES `users` (`emailId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `otps`
--

LOCK TABLES `otps` WRITE;
/*!40000 ALTER TABLE `otps` DISABLE KEYS */;
INSERT INTO `otps` VALUES ('j2@gmail.com','e429e71d27b944cfc6bd2cd06bb6193f:99b0f6ed34a9b28f36eeaea51efa8a2002c46125ae9b3aeab281e6fdba1d423e','58499','b2a1f8c29c97fdea9e968de717d2f68d:84b5786cbcfeca5792b33550589faa0b','2023-11-04 01:29:34','2023-11-04 02:29:34'),('j@gmail.com','780176aaf5a317fbccdc5969f7444c33:148be01f0057bd6d1b9a52bdfb1c7023','43300','c1f0e1fff67134378c0ec398aed76487:65faee68e76f92eb5280aa3ffca57ac1','2023-12-08 19:56:12','2023-12-08 20:56:12'),('jimrichards1920@gmail.com','65a31f14bba2b7fed649c7890e7be233:08bb017f0c4b8030f2889e374878f40c24601a39cbb6db192a431dce935974f4','77709','c19c6dad5901771d1d3930fbf5aa0355:1ea3afa51803a56b90b977f69607bc4e','2023-12-08 12:47:37','2023-12-08 13:47:37');
/*!40000 ALTER TABLE `otps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `paymentId` int NOT NULL AUTO_INCREMENT,
  `userId` int unsigned NOT NULL,
  `name_on_card` varchar(30) NOT NULL,
  `business_address_line1` varchar(50) DEFAULT NULL,
  `business_address_line2` varchar(50) DEFAULT NULL,
  `business_address_city` varchar(50) DEFAULT NULL,
  `business_address_state_code` varchar(2) DEFAULT NULL,
  `business_address_zipcode` varchar(6) DEFAULT NULL,
  `card_number` varchar(128) NOT NULL,
  PRIMARY KEY (`paymentId`),
  KEY `userId` (`userId`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `end_user` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promocode`
--

DROP TABLE IF EXISTS `promocode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promocode` (
  `promocode` varchar(15) NOT NULL,
  `discount_percent` int unsigned DEFAULT NULL,
  `max_discount` int NOT NULL,
  `is_active` bit(1) NOT NULL,
  PRIMARY KEY (`promocode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promocode`
--

LOCK TABLES `promocode` WRITE;
/*!40000 ALTER TABLE `promocode` DISABLE KEYS */;
/*!40000 ALTER TABLE `promocode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase`
--

DROP TABLE IF EXISTS `purchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase` (
  `purchaseId` int NOT NULL AUTO_INCREMENT,
  `purchase_date` timestamp NOT NULL,
  `paymentId` int NOT NULL,
  `total_price` float NOT NULL,
  `userId` int unsigned NOT NULL,
  PRIMARY KEY (`purchaseId`),
  KEY `paymentId` (`paymentId`),
  KEY `userId` (`userId`),
  CONSTRAINT `purchase_ibfk_1` FOREIGN KEY (`paymentId`) REFERENCES `payment` (`paymentId`),
  CONSTRAINT `purchase_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `end_user` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase`
--

LOCK TABLES `purchase` WRITE;
/*!40000 ALTER TABLE `purchase` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_catalog`
--

DROP TABLE IF EXISTS `ref_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_catalog`
--

LOCK TABLES `ref_catalog` WRITE;
/*!40000 ALTER TABLE `ref_catalog` DISABLE KEYS */;
INSERT INTO `ref_catalog` VALUES (1,'iPhone 13','The latest iPhone with A15 Bionic chip and dual-camera system.','mobile','A15 Bionic','Apple GPU','4GB','128GB','iOS 15','6.1 inches','Super Retina XDR','1170x2532','12MP','12MP',NULL,'Active','Approved','2023-11-01 17:47:40',1,'Top-selling mobile','Admin','2023-11-01 17:47:40'),(2,'Samsung Galaxy S21','High-performance Android smartphone with Snapdragon 888 and 120Hz display.','mobile','Snapdragon 888','Adreno 660','8GB','128GB','Android 11','6.2 inches','Dynamic AMOLED 2X','1080x2340','10MP','12MP',NULL,'Active','Approved','2023-11-01 17:47:40',1,'Best Android phone','Admin','2023-11-01 17:47:40'),(3,'Dell XPS 13','Ultra-thin laptop with Intel Core i7 and InfinityEdge display.','laptop','Intel Core i7','Intel Iris Xe','16GB','512GB SSD','Windows 10','13.4 inches','InfinityEdge','3840x2400',NULL,NULL,NULL,'Active','Approved','2023-11-01 17:47:40',1,'Premium ultrabook','Admin','2023-11-01 17:47:40'),(4,'HP Spectre x360','Convertible laptop with AMD Ryzen 7 and OLED touchscreen.','laptop','AMD Ryzen 7','AMD Radeon Graphics','16GB','1TB SSD','Windows 11','13.3 inches','OLED','3840x2160',NULL,NULL,NULL,'Active','Approved','2023-11-01 17:47:40',1,'2-in-1 laptop','Admin','2023-11-01 17:47:40'),(5,'Sony Bravia X900H','55-inch 4K Smart TV with HDR and Android TV.','television',NULL,NULL,NULL,NULL,NULL,'55 inches','LED','3840x2160',NULL,NULL,NULL,'Active','Approved','2023-11-01 17:47:40',1,'Crisp picture quality','Admin','2023-11-01 17:47:40'),(6,'LG OLED C1','65-inch OLED 4K TV with Dolby Vision and webOS.','television',NULL,NULL,NULL,NULL,NULL,'65 inches','OLED','3840x2160',NULL,NULL,NULL,'Active','Approved','2023-11-01 17:47:40',1,'Perfect for movies','Admin','2023-11-01 17:47:40'),(35,'Kkjncas','ckjsna','csanj','kjncnas','nkjds','vnjdks','vwndkj','ewnjk','vdjnk','vdnkjw','vwjk','vnjkwd','vjkw',NULL,'Active','Approved','2023-11-30 20:50:22',NULL,'No remarks',NULL,'2023-11-30 20:50:22'),(36,'Kkjncas','ckjsna','csanj','kjncnas','nkjds','vnjdks','vwndkj','ewnjk','vdjnk','vdnkjw','vwjk','vnjkwd','vjkw',NULL,'Active','Approved','2023-11-30 20:51:09',NULL,'No remarks',NULL,'2023-11-30 20:51:09'),(37,'Kkjncas','ckjsna','csanj','kjncnas','nkjds','vnjdks','vwndkj','ewnjk','vdjnk','vdnkjw','vwjk','vnjkwd','vjkw',NULL,'Active','Approved','2023-11-30 20:59:37',NULL,'No remarks',NULL,'2023-11-30 20:59:37'),(38,'Kkjncas','ckjsna','csanj','kjncnas','nkjds','vnjdks','vwndkj','ewnjk','vdjnk','vdnkjw','vwjk','vnjkwd','vjkw',NULL,'Active','Approved','2023-11-30 21:10:03',NULL,'No remarks',NULL,'2023-11-30 21:10:03'),(39,'Kkjncas','ckjsna','csanj','kjncnas','nkjds','vnjdks','vwndkj','ewnjk','vdjnk','vdnkjw','vwjk','vnjkwd','vjkw',NULL,'Active','Approved','2023-11-30 21:29:06',NULL,'No remarks',NULL,'2023-11-30 21:29:06'),(40,'Kkjncas','ckjsna','csanj','kjncnas','nkjds','vnjdks','vwndkj','ewnjk','vdjnk','vdnkjw','vwjk','vnjkwd','vjkw',NULL,'Active','Approved','2023-11-30 21:30:36',NULL,'No remarks',NULL,'2023-11-30 21:30:36'),(41,'Kkjncas','ckjsna','csanj','kjncnas','nkjds','vnjdks','vwndkj','ewnjk','vdjnk','vdnkjw','vwjk','vnjkwd','vjkw',NULL,'Active','Approved','2023-11-30 21:39:52',NULL,'No remarks',NULL,'2023-11-30 21:39:52'),(42,'Kkjncas','ckjsna','csanj','kjncnas','nkjds','vnjdks','vwndkj','ewnjk','vdjnk','vdnkjw','vwjk','vnjkwd','vjkw',NULL,'Active','Approved','2023-11-30 23:32:38',NULL,'No remarks',NULL,'2023-11-30 23:32:38'),(43,'Kkjncas','ckjsna','csanj','kjncnas','nkjds','vnjdks','vwndkj','ewnjk','vdjnk','vdnkjw','vwjk','vnjkwd','vjkw',NULL,'Active','Approved','2023-11-30 23:39:10',NULL,'No remarks',NULL,'2023-11-30 23:39:10'),(44,'Kkjncas','ckjsna','csanj','kjncnas','nkjds','vnjdks','vwndkj','ewnjk','vdjnk','vdnkjw','vwjk','vnjkwd','vjkw',NULL,'Active','Approved','2023-11-30 23:40:59',NULL,'No remarks',NULL,'2023-11-30 23:40:59'),(45,'Kkjncas','ckjsna','csanj','kjncnas','nkjds','vnjdks','vwndkj','ewnjk','vdjnk','vdnkjw','vwjk','vnjkwd','vjkw',_binary '1ooP7CWla897GcFYIm-x6xObsBVOS1lA7','Active','Approved','2023-11-30 23:53:23',NULL,'No remarks',NULL,'2023-11-30 23:53:23'),(46,'cnals','cnjds','csja','kcjsa','dksc','jk','dkj','dsc','sd','dsk','vds','vd','vd',_binary '1g_S2XE4BTUORozK6bosmPrEQjzs1uG_H','Active','Approved','2023-12-01 00:23:40',NULL,'No remarks',NULL,'2023-12-01 00:23:40'),(47,'dwqca','asa','csa','asc','asc','cvsx','asc','cas','asc','qwcs','gnf','mjh','dbf',_binary '1jl6D9A__cskDwx5XzQB9ciVv-056fmsq','Active','Approved','2023-12-03 19:13:02',NULL,'No remarks',NULL,'2023-12-03 19:13:02'),(48,'dwqca','asa','csa','asc','asc','cvsx','asc','cas','asc','qwcs','gnf','mjh','dbf',_binary '1lNTv_GtKMVUJ1x7Z3n1hSrxrbJdocUgd','Active','Approved','2023-12-03 19:17:17',NULL,'No remarks',NULL,'2023-12-03 19:17:17'),(49,'dwqca','asa','csa','asc','asc','cvsx','asc','cas','asc','qwcs','gnf','mjh','dbf',_binary '1ZvOqBqqocOe5hVSsWQT5h1JWDDkFgfym','Active','Approved','2023-12-03 19:20:28',NULL,'No remarks',NULL,'2023-12-03 19:20:28'),(50,'qq','qq','laptop','qq',NULL,NULL,'qq',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active','Approved','2023-12-06 15:42:03',NULL,'No remarks',NULL,'2023-12-06 15:42:03'),(51,'aa','aa',NULL,NULL,NULL,NULL,'aaa',NULL,NULL,'aa',NULL,NULL,NULL,NULL,'Active','Approved','2023-12-06 15:44:12',NULL,'No remarks',NULL,'2023-12-06 15:44:12'),(52,'aa','aa','smartphone',NULL,NULL,NULL,'aa',NULL,NULL,'aa',NULL,NULL,NULL,NULL,'Active','Approved','2023-12-06 15:52:35',NULL,'No remarks',NULL,'2023-12-06 15:52:35'),(53,'iPhone 14 Pro','new','smartphone',NULL,NULL,'4','4',NULL,'4','4','4','4','4',_binary 'Screenshot 2023-12-03 at 8.45.19 PM.png','Active','Approved','2023-12-06 16:11:46',NULL,'No remarks',NULL,'2023-12-06 16:11:46'),(54,'dell','aa','laptop','aa','aa','aa','aa','aa','aaa','aa','a',NULL,NULL,_binary 'Screenshot 2023-12-03 at 8.45.19 PM.png','Active','Approved','2023-12-06 16:12:55',NULL,'No remarks',NULL,'2023-12-06 16:12:55'),(55,'iPhone 15 pro','good','smartphone',NULL,NULL,'4','4',NULL,'cc','cc','cc','cc','cc',_binary 'Screenshot 2023-12-03 at 8.45.19 PM.png','Active','Approved','2023-12-06 17:00:49',NULL,'No remarks',NULL,'2023-12-06 17:00:49'),(56,'Dell','success','laptop','ss','ss','ss','ss','ss','ss','ss','ss',NULL,NULL,_binary 'Screenshot 2023-12-03 at 8.45.19 PM.png','Active','Approved','2023-12-06 17:04:19',NULL,'No remarks',NULL,'2023-12-06 17:04:19'),(57,'dell','ee','laptop','ee','ee','ee','ee','ee','ee','ee','ee',NULL,NULL,_binary 'Screenshot 2023-12-03 at 8.45.19 PM.png','Active','Approved','2023-12-06 17:52:33',NULL,'No remarks',NULL,'2023-12-06 17:52:33'),(58,'phone','ee','smartphone',NULL,NULL,'ee','ee',NULL,'ee','ee','ee','ee','ee',_binary 'Screenshot 2023-12-03 at 8.45.19 PM.png','Active','Approved','2023-12-06 18:00:54',25,'No remarks',NULL,'2023-12-06 18:00:54'),(59,'samsung','ss','smartphone',NULL,NULL,'ss','ss',NULL,'ss','ss','ss','ss','ss',_binary 'Screenshot 2023-12-03 at 8.45.19 PM.png','Active','Approved','2023-12-06 18:29:21',25,'No remarks',NULL,'2023-12-06 18:29:21'),(60,'Mac','aa','laptop','aa','aa','aa','aa','aa','aa','aa','aa',NULL,NULL,_binary 'Screenshot 2023-12-03 at 8.45.19 PM.png','Active','Approved','2023-12-06 22:01:55',25,'No remarks',NULL,'2023-12-06 22:01:55'),(61,'Motorola razr | 2023 | Unlocked | Made for US 8/128 | 32MP Camera | Cherry Blossom, 73.95 x 170.82 x 7.35mm','About this item Compatible with T-Mobile 5G and Verizon 5G. Ready for 5G on other select networks dependent on availability; contact your service provider for details. Compatible with all major 4G U.S. carriers, including Verizon, AT&T, and T-Mobile. It also works with prepaid carriers, including Cricket Wireless, Metro by T-Mobile, Simple Mobile, Total Wireless, Tracfone, Net10, Mint, TracFone, and H2O. Iconic foldable design. Flip the script with a pocket-friendly flip design in a range of fun, trendsetting colors and a vegan leather finish. Capture like never before. With Flex View, stand your phone on its own at multiple angles, giving you entirely new ways to interact, capture, and create. All-day battery life. Go a full day and night on a single charge of the 4200mAh battery*, fuel up fast with TurboPowe 30W charging, or charge wirelessly. All your essentials at a glance. View notifications, check the weather, snap a selfie, and more, all without having to flip open your phone.','Mobile','SnapdragonTM 7 Gen 1','-','8 GB','128 GB','Android 13.0','6.9','1.5” OLED External display','FHD+144Hz','32MP','64MP Main | OIS 13MP Ultra-wide + Macro',_binary '1181sjRlLNiA81Oj-fcjV6bHXSm6mJpMV','Active','Approved','2023-12-06 22:25:45',NULL,'No remarks',NULL,'2023-12-06 22:25:45'),(62,'hp','cdjnc','laptop','cc','cc','cdc','ccc','ccc','cc','cc','cccc',NULL,NULL,_binary 'Screenshot 2023-12-03 at 8.45.19 PM.png','Active','Approved','2023-12-07 21:34:27',25,'No remarks',NULL,'2023-12-07 21:34:27'),(63,'abc','kgh','smartphone',NULL,NULL,'2','3',NULL,'6','led','1080','8','8','','Active','Approved','2023-12-08 01:16:46',38,'No remarks',NULL,'2023-12-08 01:16:46'),(64,'hhp','kdn','laptop','intel','nvidia','8','90','windwos','7','oled','1080',NULL,NULL,'','Active','Approved','2023-12-08 01:25:45',38,'No remarks',NULL,'2023-12-08 01:25:45');
/*!40000 ALTER TABLE `ref_catalog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `reviewId` int NOT NULL AUTO_INCREMENT,
  `userId` int unsigned NOT NULL,
  `itemId` int unsigned NOT NULL,
  `rating` enum('1','2','3','4','5') NOT NULL,
  `comments` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`reviewId`),
  KEY `userId` (`userId`),
  KEY `itemId` (`itemId`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `end_user` (`userId`),
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`itemId`) REFERENCES `ref_catalog` (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (4,28,3,'5','Great thing to buy!!!!!'),(5,28,2,'5','Great thing to buy!!!!!'),(6,31,2,'1','Recieved Defective Item!!! Not good experience!!'),(8,22,2,'4','Bought total 4 items. Great Choice!!'),(9,32,3,'4','Loved it');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `userId` int unsigned NOT NULL,
  `ssn` int DEFAULT NULL,
  `designation` varchar(20) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) DEFAULT NULL,
  `remarks` varchar(100) DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `ref_staff_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (39,555447777,'cc','2023-11-27 23:29:14',NULL,NULL,NULL,NULL),(42,222334444,'f','2023-12-03 18:01:43',NULL,NULL,NULL,NULL),(45,222334444,'f','2023-12-03 19:17:22',NULL,NULL,NULL,NULL),(46,111223333,'admin','2023-12-06 20:31:36',NULL,NULL,NULL,NULL),(60,999999999,'cr','2023-12-08 21:16:18',NULL,NULL,NULL,NULL),(63,222331111,'senior','2023-12-08 21:26:23',NULL,NULL,NULL,NULL),(64,111223,'cr','2023-12-08 21:48:35',NULL,NULL,NULL,NULL),(65,111555444,'cr','2023-12-08 22:15:57',NULL,NULL,NULL,NULL),(66,897456321,'cr','2023-12-08 22:20:28',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stripe_user`
--

DROP TABLE IF EXISTS `stripe_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stripe_user` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `userid` int NOT NULL,
  `stripeCustomerId` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stripe_user`
--

LOCK TABLES `stripe_user` WRITE;
/*!40000 ALTER TABLE `stripe_user` DISABLE KEYS */;
INSERT INTO `stripe_user` VALUES (1,31,'cus_P4FYRrekgqeg5i');
/*!40000 ALTER TABLE `stripe_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax_and_delivery_table`
--

DROP TABLE IF EXISTS `tax_and_delivery_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tax_and_delivery_table` (
  `statecode` varchar(2) DEFAULT NULL,
  `tax_percent` int unsigned NOT NULL,
  `deliveryFee` int unsigned NOT NULL,
  `is_active` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_and_delivery_table`
--

LOCK TABLES `tax_and_delivery_table` WRITE;
/*!40000 ALTER TABLE `tax_and_delivery_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `tax_and_delivery_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `userId` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `encrypted_name` varchar(256) DEFAULT NULL,
  `emailId` varchar(50) NOT NULL,
  `encrypted_emailId` varchar(256) NOT NULL,
  `password` varchar(30) NOT NULL,
  `encrypted_password` varchar(256) NOT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `remarks` varchar(100) DEFAULT NULL,
  `status` varchar(1) DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `emailId` (`emailId`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (15,'fesd','1f5ee0f2e4ba279f501f1e951598e62a:24d9960222261ce406caa13826a191e4','asa@dv.adf','a21a22385226adcfb199dd5770d1db84:fbd221584f77e81bbe207a363a31ba51','test','229438b9be04be8011436990ca34f566:47d284ee2bb283ee383617309f0d76e9',NULL,'2023-11-02 05:41:35',NULL,NULL,NULL,NULL),(22,'Jetha','66bcaefdfde10f0b9087f63e4cb05c04:d0c9f845df6e1da7f3edf225d4a4aeb3','kpandya7@gmail.com','92398090af849a6a07ce6daf83cbab80:2e3e4a616b971db3d23f0e78fdbdde2b08e2d1c719f1308133cc177b0550ea0f','asdf','4bbfe0f98d0600dde6dbeb8ecccefd39:d1f97c364f2ccd8bf1d40919fdfab3da',NULL,'2023-11-02 23:22:37',NULL,NULL,NULL,NULL),(23,'test1','3c27dfb40d3192a777071dcbd141228b:b7d96e7fa2cf002fee28f6c75cc664b7','test1@test.com','5433127d6a6d0aab13c1bcec2e7f3fc7:cd3b165f3050419dfee0afd72b493e6f','test','96b4acdc4b04b7390709bb6bc4a5fa2a:90786d946df8857a915a50035c5613ed',NULL,'2023-11-03 05:03:41',NULL,NULL,NULL,NULL),(24,'James Anderson','5840578242487aaf6191ba5cd27a5515:36c7f26aa771ef8a8854b7e30b78e0cd','ja@gmail.com','065caad62a953e33dab2d763b95b9d64:9a94a9cf35582e5c9a5fec4ecde33f06','Ja@12345678','c9fdb495f5b8c9de7d7d3bd88c258f45:ab8b5b656c9953b597227f561f350fca',NULL,'2023-11-03 16:01:08',NULL,NULL,NULL,NULL),(25,'Kunjan','354ef78f81088ea04e17aeb74cd9b3ff:61953cbd8d00b54a1f6a5f71454cbf86','kunjan.vaghela@rutgers.edu','17a11a87ea5ef31d749442cda92c2cc0:c92ca2c4a00519008d56f4def2a6d1161a3b71cbee7e911a21fb70b0a7e2632e','Kunj123!','f8a58f0ff4cb15cefd15000d7a00e537:5903a307330f9c2ec4ad820747092600',NULL,'2023-11-03 17:04:08',NULL,NULL,NULL,NULL),(26,'Def Xyz','80b63c150bf3dfcbbd48e383f29dc31a:e4c6714215aa683a9faef6ed3a8e4e7d','def@gmail.com','678d59cc3cfaa7a22764612627b7dbec:0fb1d23c5cc7d1c3086e533a1e5a11c7','Test@123$','33cf98443c56b1d2ad11dd92ff1d4f77:9cc3c38229754c64dc610e1fd2de620d',NULL,'2023-11-03 19:43:32',NULL,NULL,NULL,NULL),(27,'Jim Richards','d70ee861587a9d1488281345048cab60:eb8a1ca402668295bb912bd73ed69cae','j@gmail.com','4173dcacc916b3601d397751b9ed2764:83dce7c3f2fcef4c1bea5dad5824a8f8bf337cc89165cde9de2c2228effda648','Test@123$','5a2aa164c578e73a891846a2e8fb90a3:6c9456c8b53effae7a70ec81a41b7c83',NULL,'2023-11-03 22:42:08',NULL,NULL,NULL,NULL),(28,'Kush Pandya','0fa5c05b16ff1557cf898e70c90dbbb0:ad9ca69e0782c75d3a06956e127f0ce7','kp@gmail.com','66304c45aca97367e0e6695c803125f8:0e97b91865dad9578e9ec664c95dbc43','kp@12345678','31e43c171fa2e9778200d4658de7efa2:5b77c959a9063e9b6476084cb55fb56e',NULL,'2023-11-03 22:43:17',NULL,NULL,NULL,NULL),(29,'bim','a6ffcc195c152c10feb317ae96d4e67f:0653f85abbd8e4581863f9b766853bcd','j2@gmail.com','cee59aed80d5c1374d1c952b530cddce:d9996b564b3ef7af02ae0d1de4590915d6541937cef1b600a823ac87cf74c4f4','Test@123$','289ffe2f917e5c43f5542dc68eef03df:8b07e1e689fc52913fb83c5b4fb1ce5b',NULL,'2023-11-04 01:20:53',NULL,NULL,NULL,NULL),(30,'BIM','b8ecad2220718134621dfce307365bda:46502618f1076fa4507bb67cf6725562','jimrichards1920@gmail.com','2efe0211d6acd1cec423e16db0d422c6:813e0621de5184fabfb1873d0f7ba8518e0bc56dfd880d2e67b059d6d4299391','Jim@Rich1','e02fa8f65a88173c284bc3a275877213:4551c9869b94277aa570b1adb5e0d777',NULL,'2023-11-04 02:19:10',NULL,NULL,NULL,NULL),(31,'Arnab','69466e1663b7b36272b24f5c26be8aae:7ec56050f859319a7c4e0a6f11953865','ash186@rutgers.edu','114e78c983b5bb14efcb3304e1e7c224:ae9ceabed614e309087d24f4dd4d4145e511c05f962c5b8d70eae57769a5c943','Test12#','0567e6b0dd476efae6bae74b2a10805c:ea80c628726cebb011863178ef64dea7',NULL,'2023-11-18 19:08:01',NULL,NULL,NULL,NULL),(32,'manad','3122992948ccebd97a058d310a212948:7f091242fb7805e71c8d069281d75472','manad@email.com','72e05d439d4ffaa307abaef32cc7de4e:8baf8786f22690e8d2466b7ad78f7e81','Manad123$','5f349ec5b2cc8d608bb15bbdc3a44b73:dba488d2b37b3bca5f50b39b970f7e7c',NULL,'2023-11-18 22:39:40',NULL,NULL,NULL,NULL),(38,'Sanchay Kanade','4fbe599f912a06397d1a0fca9f857f6c:1025e9b8d50eb1c2a15c819bdc183cff','sanchay.kanade@gmail.com','18d665f6f438b12aa2c2bd290877b27c:9a8e3ebc665faa19daa2fd9e0b1bee962394a9e8665e42066414ae0abd9abdbf','S@123456','9669d05e11d60502686513c3bb7d185b:8172221934eab7ccfcdf820b1b1391e0',NULL,'2023-11-27 22:08:40',NULL,NULL,NULL,NULL),(39,'Madhu','6a6cd66403c9ce65c82d048789e52fa8:cba327a2d0c9d305704524a0bdc3611b','ma@gmail.com','c43aa3fcf404628ab3d86ffa88103640:df59f687510353dde723b9242b24617c','Madhura54!','ec8c4951d4b4042385d59d7a04876d22:9f56b38e186619248e56fd1ce39163ff',NULL,'2023-11-27 23:29:13',NULL,NULL,NULL,NULL),(40,'manan','66af320584f9a9fa5632d87b598f6826:0156848f937281adef3bae7e2ecc17f5','test@test.com','ecf9c91a19d61cda2ccccf70211dcacd:fbf844f94568c969ff77c4d5e66df77c','TEST@123','b8686e1ac3990b589cf4c66710a2a78a:ca1019fcefa1d07bab1d873df2816c38',NULL,'2023-11-28 18:12:03',NULL,NULL,NULL,NULL),(42,'Mandar','270c3a7857cb26b6d793cd91921def85:bf77c2374fbe0c9883fc07ad260a7e68','mga@gmail.com','d71314116ebe54b7345594bb65aeacef:5218be5730010e3d2dc69c536cc0f638','Mandar54!','ed8694101c98c8df57a50f28e6852cef:76aa39e98ef8ccca6225f51d459a8329',NULL,'2023-12-03 18:01:42',NULL,NULL,NULL,NULL),(45,'hanni','3df989439142c98f9ee1595a84cde2c8:66eb754a60c387d9ba4e7cd76a2b05e7','hanni@gmail.com','a43e8ceafcbfa0a468f5896eab64d980:77f51b033891154f4b06358b8cc606b3','Hanni123!','e15b81780c1cc6fef17eff8b46072c60:a9c1cae3287de07edd945665d78c1be0',NULL,'2023-12-03 19:17:21',NULL,NULL,NULL,NULL),(46,'admin','b5e02fa4d129c84ec120f7ac59263f6c:bbc338bd094466ff911f8418af4262bc','admin@gmail.com','0a58c68331bdfab030ed34d1e347123b:8560831deb3424c66e574d0b8dfcc6af','Admin1000@','3088f0a1990ada4848b1cb607b30c6da:45b037baf6cd982c37be105aaa6216ad',NULL,'2023-12-06 20:31:35',NULL,NULL,NULL,NULL),(52,'Ana','5fbff2305429426b317ae66302925844:182cf3968faf3d43b2b4aae161ad38f0','ana@gmail.com','9d06fa025867bea6fbfcdfdaade73f6a:1f0fe9b6607227da4a01705c09fd2c07','Ana123!','dded3f952e2f1442c9ce190312bc1c8a:ea8c8befd435bd0dd001494354931461',NULL,'2023-12-08 18:00:08',NULL,NULL,NULL,NULL),(59,'Yujia Cheng','77680629db3a29341a06ba8a623463ae:b2ff6f824d62b8ee123637ceb98580ec','yuria_yin@gmail.com','2a55245df72dd73af43f64ede737e842:47cb6dbed875324d5fda94eff981019dd211db6ffc33e06b623494eb43f0a417','Apple_yin1','2445650226ce7351ca1fcfdfdc917eeb:3490efac4ed2675887f26e26ef14c70f',NULL,'2023-12-08 21:01:19',NULL,NULL,NULL,NULL),(60,'sanchay','263ccad088f15961692e608e763453d4:2823858d4e0eee55bbe803f555d6b57d','sanchay.k@gmail.com','4eceac8c8c3685f684c8199bd692ac09:464147b59a5318190d874ac2ede0f090242cf15e4c36347b62a0c7fcdd542fd4','*Sanchay25','602b34c4aea268ffd717c829e4d120c2:5fac0579efb5c38478c99fb2af6b9006',NULL,'2023-12-08 21:16:18',NULL,'A',NULL,NULL),(61,'Yujia C','44a19c0b90a1d03fa5c628d14ab3e1ba:afa8b9381e88101792b3e79b3b5d35f6','yuriayin@gmail.com','e71ef9f7fcfecceb08b78aebb3845a5d:a93406575ebf91816e39aa2109ec03c616fa2f626dc09bbfe4580ec3dab55f66','Apple@yin1','4006e44fceb020aa04e51541177a1f11:d91f9f08f5ef58246b1615a4339b365d',NULL,'2023-12-08 21:18:57',NULL,'A',NULL,NULL),(63,'ranbir','f4450fbaa2d6be18874effce61409625:5d7abdd9442ba627ee1f959003a8d438','ranbir@gmail.com','c828267461c51655ab5c5e2680ce9682:1ea6ea513047f16985a5f87a24c01cdb13c695e89e83f7b560d6c8fb7559a76d','Ranbir5000@','ee812400c315798e0970f237bc0fc45a:72ef1c69b08c2f985ddf7798359e80ae',NULL,'2023-12-08 21:26:22',NULL,'A',NULL,NULL),(64,'deepika','2c03385aad6ed754d1ff92b78f8d5970:9dc42a2cab7bd60dbd314fae9d5b9b12','dp@gmail.com','1fcb949be3f70eb598239254d00842cc:1eed1e13da4be2a1f6dd450c00abd60e','D123456!','0c4f9d13f76fb31f89d539bc350f7971:1c5ad8f1f7dab9f7d48685dffd95e840',NULL,'2023-12-08 21:48:35',NULL,'I',NULL,NULL),(65,'dummy','c418e5316c0d91abd77958224b5b1a1b:7d400d27bce9cc69c4e0b546ff54ba88','dummy@gmail.com','bb0bd655d744f3b72464f936245a4120:679c9b1370e917aea961608351413f5a','*Sanchay252','c4dffa1c67a10de27f433bd0695a3a4e:ab19d54900be0179beb9cff2bf9e8054',NULL,'2023-12-08 22:15:57',NULL,'I',NULL,NULL),(66,'dummy2','e6cb38c6ba82ab29aa4a9818df9bd645:8cd5086346d44a6161f888e9135e6121','dummy2@gmail.com','433436548c3ee68026af7cc235bdf03f:6efe0d32f6ac5562891d047f3a4fd1db5cb91caea6e496f645ff660e3b340bc8','*Sanchay252','6d22917acb80e8f3d2d18b122f0b75cb:7c6e307b9f757f064d820f255df37053',NULL,'2023-12-08 22:20:29',NULL,'I',NULL,NULL),(67,'KUSH JAYANK PANDYA','9e3bb8820f1e8a3da8bae863aadd5e09:a6ee8cbe979616f99f6dfb8a1c0c9d7e584d2cd8e4d5331cca49517b685de05e','blah1@gmail.com','98feb8bf89497bc496ff7c1c8f62aa2d:fb3ed48660c712056877a9c148a70758','Riverside@1','2f6c392e3f9b38684349b934e965b99f:94bfae78de8b1090bb15e4ddd0052d4f',NULL,'2023-12-09 00:40:16',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-08 21:44:48
