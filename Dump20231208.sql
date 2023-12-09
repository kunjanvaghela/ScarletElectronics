CREATE DATABASE  IF NOT EXISTS `bjy4c3bfqe9mnlvfzpwb` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bjy4c3bfqe9mnlvfzpwb`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: bjy4c3bfqe9mnlvfzpwb
-- ------------------------------------------------------
-- Server version	8.0.32

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
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (13,2,15,3),(14,3,15,2),(15,4,15,1),(16,2,22,2),(17,3,22,4),(18,4,22,2),(24,2,25,1),(50,2,26,1),(54,2,32,1),(55,7,32,1);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_info`
--

DROP TABLE IF EXISTS `delivery_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery_info` (
  `deliveryId` int NOT NULL AUTO_INCREMENT,
  `purchaseId` int NOT NULL,
  `estimated_delivery_date` timestamp NULL DEFAULT NULL,
  `actual_delivery_date` timestamp NULL DEFAULT NULL,
  `delivery_address_line1` varchar(50) DEFAULT NULL,
  `delivery_address_line2` varchar(50) DEFAULT NULL,
  `delivery_address_city` varchar(50) DEFAULT NULL,
  `delivery_address_state_code` varchar(2) DEFAULT NULL,
  `delivery_address_zipcode` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`deliveryId`),
  KEY `purchaseId` (`purchaseId`),
  CONSTRAINT `delivery_info_ibfk_1` FOREIGN KEY (`purchaseId`) REFERENCES `purchase` (`purchaseId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_info`
--

LOCK TABLES `delivery_info` WRITE;
/*!40000 ALTER TABLE `delivery_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `delivery_info` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `end_user`
--

LOCK TABLES `end_user` WRITE;
/*!40000 ALTER TABLE `end_user` DISABLE KEYS */;
INSERT INTO `end_user` VALUES (15,'asc','asca','as','OR','asfcaa','sdbv',NULL,'2023-11-02 05:41:36',NULL,NULL),(22,'10 Paul Robeson','5A','Phelps','CA','08901','1324539203',NULL,'2023-11-02 23:22:38',NULL,NULL),(23,'9 Snclas','nsclam','nkcas','AR','08901','123456789',NULL,'2023-11-03 05:03:42',NULL,NULL),(24,'10 Paul Robeson Blvd','APT-9N','New Brunswick','NJ','08901','8488228389',NULL,'2023-11-03 16:01:08',NULL,NULL),(25,'10 Paul','Blvd','New Brunswick','NJ','08901','8481817457',NULL,'2023-11-03 17:04:09',NULL,NULL),(26,'Dummy','dummy','New Brunswick','AL','08901','12345678910',NULL,'2023-11-03 19:43:33',NULL,NULL),(27,'100, Third Street','College Ave','New Brunswick','AL','08901','234893216432',NULL,'2023-11-03 22:42:09',NULL,NULL),(28,'sndksndkmwkmd','snjdnsdnkdkw','kdnwkdkwmd','NJ','08901','8989888089',NULL,'2023-11-03 22:43:17',NULL,NULL),(29,'1 Richmond Street','Apt 1079','New Brunswick','AL','08901','17325226523',NULL,'2023-11-04 01:20:53',NULL,NULL),(30,'1 Richmond St. #1079, New Brunswick, NJ 08901','test','New Brunswick','NJ','08901','7325226783',NULL,'2023-11-04 02:19:10',NULL,NULL),(31,'1 Richmond St. #1079, New Brunswick, NJ 08901','test','New Brunswick','AL','08901','7325226785',NULL,'2023-11-04 02:37:48',NULL,NULL),(32,'1 Richmond St.','Apt  #1079','New Brunswick','NJ','08901','1234567891',NULL,'2023-11-04 03:13:08',NULL,NULL),(33,'1 Richmond St. #1079, New Brunswick, NJ 08901','test','New Brunswick','AL','08901','7325226712',NULL,'2023-11-04 03:30:58',NULL,NULL);
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
  `update_description` varchar(200) DEFAULT NULL,
  `current_status` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`requestId`),
  KEY `userId` (`userId`),
  CONSTRAINT `enduserrequests_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `end_user` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `end_user_request`
--

LOCK TABLES `end_user_request` WRITE;
/*!40000 ALTER TABLE `end_user_request` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
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
  PRIMARY KEY (`listingId`),
  KEY `sellerId` (`sellerId`),
  KEY `itemId` (`itemId`),
  CONSTRAINT `item_listing_ibfk_1` FOREIGN KEY (`sellerId`) REFERENCES `end_user` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `item_listing_ibfk_2` FOREIGN KEY (`itemId`) REFERENCES `ref_catalog` (`itemId`) ON DELETE CASCADE,
  CONSTRAINT `item_listing_chk_1` CHECK ((`quantity` >= 0)),
  CONSTRAINT `item_listing_chk_2` CHECK ((`price` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_listing`
--

LOCK TABLES `item_listing` WRITE;
/*!40000 ALTER TABLE `item_listing` DISABLE KEYS */;
INSERT INTO `item_listing` VALUES (2,1,15,1200.78,'2023-11-02 21:39:49',NULL,NULL,NULL,NULL,12),(3,2,15,580,'2023-11-02 23:15:12',NULL,NULL,NULL,NULL,31),(4,3,15,2300,'2023-11-02 23:15:32',NULL,NULL,NULL,NULL,12),(7,5,25,656.99,'2023-11-03 17:04:39',NULL,NULL,NULL,NULL,23),(11,4,25,640,'2023-11-04 02:56:17',NULL,NULL,NULL,NULL,32),(12,28,25,45,'2023-11-04 03:05:23',NULL,NULL,NULL,NULL,3);
/*!40000 ALTER TABLE `item_listing` ENABLE KEYS */;
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
  PRIMARY KEY (`orderId`),
  KEY `listingId` (`listingId`),
  CONSTRAINT `order_detail_ibfk_1` FOREIGN KEY (`listingId`) REFERENCES `item_listing` (`listingId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `otps`
--

LOCK TABLES `otps` WRITE;
/*!40000 ALTER TABLE `otps` DISABLE KEYS */;
INSERT INTO `otps` VALUES ('j2@gmail.com','e429e71d27b944cfc6bd2cd06bb6193f:99b0f6ed34a9b28f36eeaea51efa8a2002c46125ae9b3aeab281e6fdba1d423e','58499','b2a1f8c29c97fdea9e968de717d2f68d:84b5786cbcfeca5792b33550589faa0b','2023-11-04 01:29:34','2023-11-04 02:29:34'),('j@gmail.com','8169ad2fec216c71ecc7d7dc846a7ddc:b9d93b5063b5e99cb8a8d26db71e91ebfede871a5e5430f6792f4b487dc93227','27028','33baa05e31d14730876924c435b47c29:37a396a941dffe828bc2a18868606972','2023-11-03 23:31:03','2023-11-04 00:31:03'),('jimrichards1920@gmail.com','ce35af50b8e2acbde6d440544fdfc772:0576806c871eb051685a86b0bd484e708ab20e8090ac08c7b2b8299a65dc2b26','95171','078b3743b75b4ab305ef74b3c83fe7f1:8794e21e77f62b7d3fdb655cfcf691b6','2023-11-04 03:31:32','2023-11-04 04:31:32');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
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
  PRIMARY KEY (`purchaseId`),
  KEY `paymentId` (`paymentId`),
  CONSTRAINT `purchase_ibfk_1` FOREIGN KEY (`paymentId`) REFERENCES `payment` (`paymentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_catalog`
--

LOCK TABLES `ref_catalog` WRITE;
/*!40000 ALTER TABLE `ref_catalog` DISABLE KEYS */;
INSERT INTO `ref_catalog` VALUES (1,'iPhone 13','The latest iPhone with A15 Bionic chip and dual-camera system.','mobile','A15 Bionic','Apple GPU','4GB','128GB','iOS 15','6.1 inches','Super Retina XDR','1170x2532','12MP','12MP',NULL,'Active','Approved','2023-11-01 17:47:40',1,'Top-selling mobile','Admin','2023-11-01 17:47:40'),(2,'Samsung Galaxy S21','High-performance Android smartphone with Snapdragon 888 and 120Hz display.','mobile','Snapdragon 888','Adreno 660','8GB','128GB','Android 11','6.2 inches','Dynamic AMOLED 2X','1080x2340','10MP','12MP',NULL,'Active','Approved','2023-11-01 17:47:40',1,'Best Android phone','Admin','2023-11-01 17:47:40'),(3,'Dell XPS 13','Ultra-thin laptop with Intel Core i7 and InfinityEdge display.','laptop','Intel Core i7','Intel Iris Xe','16GB','512GB SSD','Windows 10','13.4 inches','InfinityEdge','3840x2400',NULL,NULL,NULL,'Active','Approved','2023-11-01 17:47:40',1,'Premium ultrabook','Admin','2023-11-01 17:47:40'),(4,'HP Spectre x360','Convertible laptop with AMD Ryzen 7 and OLED touchscreen.','laptop','AMD Ryzen 7','AMD Radeon Graphics','16GB','1TB SSD','Windows 11','13.3 inches','OLED','3840x2160',NULL,NULL,NULL,'Active','Approved','2023-11-01 17:47:40',1,'2-in-1 laptop','Admin','2023-11-01 17:47:40'),(5,'Sony Bravia X900H','55-inch 4K Smart TV with HDR and Android TV.','television',NULL,NULL,NULL,NULL,NULL,'55 inches','LED','3840x2160',NULL,NULL,NULL,'Active','Approved','2023-11-01 17:47:40',1,'Crisp picture quality','Admin','2023-11-01 17:47:40'),(6,'LG OLED C1','65-inch OLED 4K TV with Dolby Vision and webOS.','television',NULL,NULL,NULL,NULL,NULL,'65 inches','OLED','3840x2160',NULL,NULL,NULL,'Active','Approved','2023-11-01 17:47:40',1,'Perfect for movies','Admin','2023-11-01 17:47:40'),(27,'Apple Iphone 15','Latest Iphone','Mobile','A14','Arena','12','512GB','Android','13','21','43','12','5','','Active','Approved','2023-11-04 02:58:06',NULL,'No remarks',NULL,'2023-11-04 02:58:06'),(28,'Aple Iphone 15','Mobile','Mobile','Adreana','GP','52 GB','512 GB','12','123','32','12','5 MP','54','','Active','Approved','2023-11-04 03:04:44',NULL,'No remarks',NULL,'2023-11-04 03:04:44');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
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
  `date_of_birth` date DEFAULT NULL,
  `designation` varchar(10) DEFAULT NULL,
  `status` varchar(1) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) DEFAULT NULL,
  `remarks` varchar(100) DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `ref_staff_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (15,'fesd','1f5ee0f2e4ba279f501f1e951598e62a:24d9960222261ce406caa13826a191e4','asa@dv.adf','a21a22385226adcfb199dd5770d1db84:fbd221584f77e81bbe207a363a31ba51','test','229438b9be04be8011436990ca34f566:47d284ee2bb283ee383617309f0d76e9',NULL,'2023-11-02 05:41:35',NULL,NULL,NULL,NULL),(22,'Jetha','66bcaefdfde10f0b9087f63e4cb05c04:d0c9f845df6e1da7f3edf225d4a4aeb3','kpandya7@gmail.com','92398090af849a6a07ce6daf83cbab80:2e3e4a616b971db3d23f0e78fdbdde2b08e2d1c719f1308133cc177b0550ea0f','asdf','4bbfe0f98d0600dde6dbeb8ecccefd39:d1f97c364f2ccd8bf1d40919fdfab3da',NULL,'2023-11-02 23:22:37',NULL,NULL,NULL,NULL),(23,'test1','3c27dfb40d3192a777071dcbd141228b:b7d96e7fa2cf002fee28f6c75cc664b7','test1@test.com','5433127d6a6d0aab13c1bcec2e7f3fc7:cd3b165f3050419dfee0afd72b493e6f','test','96b4acdc4b04b7390709bb6bc4a5fa2a:90786d946df8857a915a50035c5613ed',NULL,'2023-11-03 05:03:41',NULL,NULL,NULL,NULL),(24,'James Anderson','5840578242487aaf6191ba5cd27a5515:36c7f26aa771ef8a8854b7e30b78e0cd','ja@gmail.com','065caad62a953e33dab2d763b95b9d64:9a94a9cf35582e5c9a5fec4ecde33f06','Ja@12345678','c9fdb495f5b8c9de7d7d3bd88c258f45:ab8b5b656c9953b597227f561f350fca',NULL,'2023-11-03 16:01:08',NULL,NULL,NULL,NULL),(25,'Kunjan','354ef78f81088ea04e17aeb74cd9b3ff:61953cbd8d00b54a1f6a5f71454cbf86','kunjan.vaghela@rutgers.edu','17a11a87ea5ef31d749442cda92c2cc0:c92ca2c4a00519008d56f4def2a6d1161a3b71cbee7e911a21fb70b0a7e2632e','Kunj123!','f8a58f0ff4cb15cefd15000d7a00e537:5903a307330f9c2ec4ad820747092600',NULL,'2023-11-03 17:04:08',NULL,NULL,NULL,NULL),(26,'Def Xyz','80b63c150bf3dfcbbd48e383f29dc31a:e4c6714215aa683a9faef6ed3a8e4e7d','def@gmail.com','678d59cc3cfaa7a22764612627b7dbec:0fb1d23c5cc7d1c3086e533a1e5a11c7','Test@123$','33cf98443c56b1d2ad11dd92ff1d4f77:9cc3c38229754c64dc610e1fd2de620d',NULL,'2023-11-03 19:43:32',NULL,NULL,NULL,NULL),(27,'Jim Richards','d70ee861587a9d1488281345048cab60:eb8a1ca402668295bb912bd73ed69cae','j@gmail.com','4173dcacc916b3601d397751b9ed2764:83dce7c3f2fcef4c1bea5dad5824a8f8bf337cc89165cde9de2c2228effda648','Test@123$','5a2aa164c578e73a891846a2e8fb90a3:6c9456c8b53effae7a70ec81a41b7c83',NULL,'2023-11-03 22:42:08',NULL,NULL,NULL,NULL),(28,'Kush Pandya','0fa5c05b16ff1557cf898e70c90dbbb0:ad9ca69e0782c75d3a06956e127f0ce7','kp@gmail.com','66304c45aca97367e0e6695c803125f8:0e97b91865dad9578e9ec664c95dbc43','kp@12345678','31e43c171fa2e9778200d4658de7efa2:5b77c959a9063e9b6476084cb55fb56e',NULL,'2023-11-03 22:43:17',NULL,NULL,NULL,NULL),(32,'Mitul','c0fe4fdac18afbe17f073276359fcbf6:e60617c501d637e41c4ca1624654807f','mitul.shah1@rutgers.edu','2d3fab35a4b8fd2d6c696d79e0d1ba94:1cc88b0c85a9522d9aa85ac2ac531a9ddea790399aa23c7e130223e05799d247','Test@123$','676bf0e86f6b7e2744d7f3ba70793a61:c909688fcf939d42d372b547b596980f',NULL,'2023-11-04 03:13:08',NULL,NULL,NULL,NULL),(33,'Bim','9ed06142640856fecf5ff7b9800193db:fdc36d9981bf19a51894c3f495ebd3f3','jimrichards1920@gmail.com','b9b9f5c1f4c02b6df73af3a516c025a8:ef2f82a2bdf8c0a2b7822d25119344673c557418b126b73f7075f3ed4fabe665','TEST@1234','d24e52a9b574ca6e8aab6632a7c8b3e5:9978c3c4eed598611880d6fc55dfa0f9',NULL,'2023-11-04 03:30:58',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'bjy4c3bfqe9mnlvfzpwb'
--

--
-- Dumping routines for database 'bjy4c3bfqe9mnlvfzpwb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-08 20:35:10
