create schema scarletelectronics2;
use scarletelectronics2;



DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `userId` int(10) unsigned NOT NULL AUTO_INCREMENT,
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
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (75,'Jim Richards','e08f885b60a3e30619149cb470ec4b4c:7b120abe74cbf78f6f4a2cd6c98ae970','jimrichards1920@gmail.com','1a3ffec32d6e26981e46099789a3c055:14cf3badd2b842145e212172a99b1033b53ab859f5cadff830d6cdc3d6761787','Jim@Rich1','2fb2ca77bdc4ad4807f09cdd849cb866:f4d11532cbbe3d8f5872b01d9ebbeb4a',NULL,'2023-12-10 23:27:55',NULL,NULL,NULL,NULL),(76,'Manad','436173e30d855e84a7d35507b1a64c59:7c74a876a42cbd4c754d18d2de399a77','desaiamand123@gmail.com','63b84537ed8a2bd5019fd4e1ed40e24d:01531aa5680713f229854d572860a5faebb429118c786266d561d42f44890a33','Manad123$','58bfa6fd154fb037db90aa7bb212bed8:b95e4f55887a84c00882f630569b5607',NULL,'2023-12-10 23:33:44',NULL,NULL,NULL,NULL),(77,'Manad Desai','bfcef48d2a67e9850fa958d3571c237f:3e32c854c977a91b53a22430abb75336','desaimanad123@gmail.com','bf0394b54367cee2e2ce95a13486152c:40cf81d10cee1d0c41fac64ef5e8aa22425478eea1bec807f8fd57b2157998c3','Manad123$','9924ab23123fb1d1939c7f676e6b5fe3:1d08e53241e1d870efbc92115201510d',NULL,'2023-12-10 23:35:34',NULL,NULL,NULL,NULL),(78,'Mitul','ce54b5abd9c2076b52e50c639e101680:a9193c9967628a1f03d837dbfb44149b','mitul.shah1@rutgers.edu','1a883f160ee7f9568c4dea6f5114f0b0:a5f0aad17f93bf882c07bef174ef782e16fdec29021ac6e3ef4293480df4e344','Mitul@Root','ac3e8f8f2efcda220c2e0363ee8bdf94:fcdb532421fb65694a2a7aa7b255fa29',NULL,'2023-12-11 00:33:43',NULL,NULL,NULL,NULL),(79,'Manan','90e40c1ad92c98da02b24f6e13ca0022:72a7297d0b761d9b622d26a681e0fb45','desaimanad1999@gmail.com','dea6a61d874d374db0c528ddd802af3a:5e1a8d96b05359900f6093db817228df75c9cf567ab161ceff6e38a9317c9564','Manan123$','c1c740a7be88346912bf6c1756c49467:cb0c5b04e3d2856d986f7592a5dd3820',NULL,'2023-12-11 00:47:53',NULL,NULL,NULL,NULL),(80,'Kunjan','29626580fdbe2ed7dda947942d25ea6b:a2150e369052b629251607c6eb4b73c1','kunjan.vaghela@rutgers.edu','5774c97cf00fa733fa90d1112b12e244:339470a9ae81a63dc1ed7fe5c071ebd4df4e144c42a4edefaf9fd287dbf41854','Kunj123!','e0253f823e6404083fcf4188ff8020f0:3428ef4939a8a6aacb136ec7a558466e',NULL,'2023-12-11 01:01:16',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS `end_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `end_user` (
  `userId` int(10) unsigned NOT NULL,
  `address_line1` varchar(50) DEFAULT NULL,
  `address_line2` varchar(50) DEFAULT NULL,
  `address_city` varchar(50) DEFAULT NULL,
  `address_state_code` varchar(2) DEFAULT NULL,
  `address_zipcode` varchar(6) DEFAULT NULL,
  `phone_nr` varchar(15) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int(11) DEFAULT NULL,
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
INSERT INTO `end_user` VALUES (75,'1 Richmond Street','Apt 5000','New Brunswick','NJ','08901','7325221000',NULL,'2023-12-10 23:27:55',NULL,NULL),(76,'10 Paul Robeson Blvd',' APT-9N','New Brunswick','NJ','08901','8048540645',NULL,'2023-12-10 23:33:44',NULL,NULL),(77,'10 Paul Robeson Blvd','APT-10S','New Brunswick','NJ','08901','8048540678',NULL,'2023-12-10 23:35:34',NULL,NULL),(78,'10 Commercial Ave','Apt 1091','New Brunswick','NJ','08901','7325226000',NULL,'2023-12-11 00:33:43',NULL,NULL),(79,'10 Paul Robeson Blvd','1S','United States','NJ','08901','8048540966',NULL,'2023-12-11 00:47:53',NULL,NULL),(80,'10 Paul Robeson','43P','New Brunswick','NJ','08901','8483918450',NULL,'2023-12-11 01:01:16',NULL,NULL);
/*!40000 ALTER TABLE `end_user` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `end_user`
--



--
-- Table structure for table `end_user_request`
--

DROP TABLE IF EXISTS `end_user_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `end_user_request` (
  `requestId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(10) unsigned NOT NULL,
  `listingId` int(10) unsigned DEFAULT NULL,
  `update_description` varchar(200) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `current_status` varchar(5) DEFAULT NULL,
  `customer_rep` int(10) unsigned DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  PRIMARY KEY (`requestId`),
  KEY `userId` (`userId`),
  KEY `listingId` (`listingId`),
  CONSTRAINT `enduserrequests_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `end_user` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `end_user_request`
--

LOCK TABLES `end_user_request` WRITE;
/*!40000 ALTER TABLE `end_user_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `end_user_request` ENABLE KEYS */;
UNLOCK TABLES;





DROP TABLE IF EXISTS `ref_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ref_catalog` (
  `itemId` int(10) unsigned NOT NULL AUTO_INCREMENT,
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
  `created_by` int(11) DEFAULT NULL,
  `remarks` varchar(350) DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8;




DROP TABLE IF EXISTS `purchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase` (
  `purchaseId` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_date` timestamp NOT NULL,
  `paymentId` varchar(50) NOT NULL,
  `total_price` float NOT NULL,
  `userId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`purchaseId`),
  KEY `paymentId` (`paymentId`),
  KEY `userId` (`userId`),
  CONSTRAINT `purchase_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `end_user` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase`
--

LOCK TABLES `purchase` WRITE;
/*!40000 ALTER TABLE `purchase` DISABLE KEYS */;
INSERT INTO `purchase` VALUES (6,'2023-12-11 00:36:24','pi_3OLxTZDB1UugWx3S07VhhRF4',2050,78),(7,'2023-12-11 00:45:16','pi_3OLxbkDB1UugWx3S0LfUpagc',2600,78),(8,'2023-12-11 00:50:43','pi_3OLxgnDB1UugWx3S1TNATnS1',2850,79),(9,'2023-12-11 01:07:25','pi_3OLxxEDB1UugWx3S1ToZeDN2',2250,80),(10,'2023-12-11 01:34:00','pi_3OLyN9DB1UugWx3S19u048mq',4160,75);
/*!40000 ALTER TABLE `purchase` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Table structure for table `favourite`
--

DROP TABLE IF EXISTS `favourite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favourite` (
  `favouriteId` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(10) unsigned NOT NULL,
  `itemId` int(10) unsigned NOT NULL,
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



LOCK TABLES `ref_catalog` WRITE;
/*!40000 ALTER TABLE `ref_catalog` DISABLE KEYS */;
INSERT INTO `ref_catalog` VALUES (67,'Dell Inspiron 15','The Dell Inspiron 15 is a powerful laptop featuring an Intel Core i7 processor, NVIDIA GeForce GTX 1650 GPU, 16GB RAM, and 512GB storage. It runs on Windows 11 and sports a 15.6-inch IPS display with a resolution of 1920x1080. ','laptop','Intel Core i7','NVIDIA GeForce GTX 1650 GPU','16 GB','512GB','Windows 11','15.6 inch','IPS','1920x1080',NULL,NULL,_binary '1fPaj12nmL35aVrOD7mjCbzZcKXgIPOH6','Active','Approved','2023-12-11 00:08:55',75,'No remarks',NULL,'2023-12-11 00:08:55'),(68,'HP Pavilion Gaming Laptop','The HP Pavilion Gaming Laptop is designed for gaming enthusiasts.','laptop','AMD Ryzen 7','NVIDIA GeForce RTX 3060','16GB','512 GB','Windows 10','15.6 inch','LED','1920x1080',NULL,NULL,_binary '1xKibMXN21VcgPC7yaQ1WDJNuqZ_isYLE','Active','Approved','2023-12-11 00:13:05',75,'No remarks',NULL,'2023-12-11 00:13:05'),(69,'Samsung Galaxy S21 Ultra','The Samsung Galaxy S21 Ultra is a flagship smartphone...','smartphone',NULL,NULL,'12GB','256GB',NULL,'6.8 Inch','Dynamic AMOLED','3200x1440','40MP','108MP',_binary '1SbLV9Fxtf-cSn_1HQvCXtFxoZNrR6Iak','Active','Approved','2023-12-11 00:15:47',77,'No remarks',NULL,'2023-12-11 00:15:47'),(70,'Google Pixel 6 Pro','The Google Pixel 6 Pro is a feature-packed smartphone...','smartphone',NULL,NULL,'8GB','128GB',NULL,'6.7 Inch','LTPO OLED','3120x1440','12MP','50MP',NULL,'Active','Approved','2023-12-11 00:19:15',77,'No remarks',NULL,'2023-12-11 00:19:15'),(71,'Google Pixel 6 Pro','The Google Pixel 6 Pro is a feature-packed smartphone...','smartphone',NULL,NULL,'8GB','128GB',NULL,'6.7 Inch','LTPO OLED','3120x1440','40MP','50MP',_binary '1e-7Iwf6VlMOtMeW0Kc59aV6y_dkfsKK8','Active','Approved','2023-12-11 00:20:27',77,'No remarks',NULL,'2023-12-11 00:20:27'),(72,'Apple iPhone 13 Pro Max','The Apple iPhone 13 Pro Max is a premium smartphone...','smartphone',NULL,NULL,'6GB','512GB',NULL,'6.7 Inch','Super Retina XDR','2778x1284','12MP','12MP',_binary '1c3QRm_twMgQvg6EnlJRHqckM7vf3iBpN','Active','Approved','2023-12-11 00:22:35',77,'No remarks',NULL,'2023-12-11 00:22:35'),(73,'Asus ROG Strix G15','The Asus ROG Strix G15 is a high-performance gaming laptop.','laptop','AMD Ryzen 9','NVIDIA GeForce RTX 3070','32 GB','1000 GB','Windows 11','14 inch','IPS','1920x1080',NULL,NULL,_binary '1Morii5PVFDsS3e0cgmY8-bu2clHZ6NTZ','Active','Approved','2023-12-11 00:24:08',75,'No remarks',NULL,'2023-12-11 00:24:08'),(74,'Xiaomi Mi 11','The Xiaomi Mi 11 features a powerful Snapdragon 888 processor...','smartphone',NULL,NULL,'8GB','512GB',NULL,'6.8 Inch','AMOLED','3200x1440','20MP','108MP',_binary '1FCLXIWGW53-qVq8U36ayHtbC1WzZMt8X','Active','Approved','2023-12-11 00:25:07',77,'No remarks',NULL,'2023-12-11 00:25:07'),(75,'OnePlus 9 Pro','The OnePlus 9 Pro comes with a Snapdragon 888 chipset...','smartphone',NULL,NULL,'12GB','256GB',NULL,'6.7 Inch','Fluid AMOLED','3216x1440','16MP','48MP',_binary '1vbH7koNohXG9hOVyUAfrUOKtaQKHCk1c','Active','Approved','2023-12-11 00:28:15',77,'No remarks',NULL,'2023-12-11 00:28:15');
/*!40000 ALTER TABLE `ref_catalog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_listing`
--

DROP TABLE IF EXISTS `item_listing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_listing` (
  `listingId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemId` int(10) unsigned NOT NULL,
  `sellerId` int(10) unsigned NOT NULL,
  `price` float NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) DEFAULT NULL,
  `remarks` varchar(100) DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `quantity` int(10) unsigned DEFAULT '0',
  `listing_status` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`listingId`),
  KEY `sellerId` (`sellerId`),
  KEY `itemId` (`itemId`),
  CONSTRAINT `item_listing_ibfk_1` FOREIGN KEY (`sellerId`) REFERENCES `end_user` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `item_listing_ibfk_2` FOREIGN KEY (`itemId`) REFERENCES `ref_catalog` (`itemId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_listing`
--

LOCK TABLES `item_listing` WRITE;
/*!40000 ALTER TABLE `item_listing` DISABLE KEYS */;
INSERT INTO `item_listing` VALUES (20,67,75,1200,'2023-12-11 00:09:43',NULL,NULL,NULL,NULL,22,NULL),(21,68,75,1600,'2023-12-11 00:14:06',NULL,NULL,NULL,NULL,25,NULL),(22,69,77,800,'2023-12-11 00:16:09',NULL,NULL,NULL,NULL,28,NULL),(23,71,77,560,'2023-12-11 00:20:42',NULL,NULL,NULL,NULL,49,NULL),(24,72,77,900,'2023-12-11 00:23:14',NULL,NULL,NULL,NULL,41,NULL),(25,73,75,2050,'2023-12-11 00:24:36',NULL,NULL,NULL,NULL,18,NULL),(26,74,77,450,'2023-12-11 00:25:22',NULL,NULL,NULL,NULL,72,NULL),(27,75,77,430,'2023-12-11 00:28:31',NULL,NULL,NULL,NULL,80,NULL),(28,67,77,1800,'2023-12-11 01:50:32',NULL,NULL,NULL,NULL,20,NULL);
/*!40000 ALTER TABLE `item_listing` ENABLE KEYS */;
UNLOCK TABLES;










DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `cartId` int(11) NOT NULL AUTO_INCREMENT,
  `listingId` int(10) unsigned NOT NULL,
  `userId` int(10) unsigned NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`cartId`),
  KEY `userId` (`userId`),
  KEY `listingId` (`listingId`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `end_user` (`userId`),
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`listingId`) REFERENCES `item_listing` (`listingId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8;

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
-- INSERT INTO `cart` VALUES (109,26,79,1),(115,24,75,4),(116,20,75,1),(117,27,75,1),(118,26,75,1),(119,25,75,1),(120,22,75,1),(121,20,77,1);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;





--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `messageId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `requestId` int(10) unsigned NOT NULL,
  `userId` int(10) unsigned NOT NULL,
  `customer_rep` int(10) unsigned DEFAULT NULL,
  `listingId` int(10) unsigned DEFAULT NULL,
  `update_description` varchar(200) DEFAULT NULL,
  `created_on` datetime NOT NULL,
  `created_by` varchar(20) NOT NULL,
  PRIMARY KEY (`messageId`),
  KEY `requestId` (`requestId`),
  KEY `userId` (`userId`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`requestId`) REFERENCES `end_user_request` (`requestId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `end_user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_detail` (
  `orderId` int(11) NOT NULL AUTO_INCREMENT,
  `listingId` int(10) unsigned NOT NULL,
  `purchaseId` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `total_cost_of_item` float NOT NULL,
  `shipmentId` varchar(50) DEFAULT NULL,
  `trackingId` varchar(50) DEFAULT NULL,
  `trackingUrl` varchar(150) NOT NULL,
  `order_status` varchar(50) DEFAULT NULL,
  `return_shipment` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`orderId`),
  KEY `purchaseId` (`purchaseId`),
  KEY `listingId` (`listingId`),
  CONSTRAINT `order_detail_ibfk_1` FOREIGN KEY (`purchaseId`) REFERENCES `purchase` (`purchaseId`) ON DELETE CASCADE,
  CONSTRAINT `order_detail_ibfk_2` FOREIGN KEY (`listingId`) REFERENCES `item_listing` (`listingId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
-- INSERT INTO `order_detail` VALUES (10,25,6,1,2255,'shp_5fb022a68b5842a39a696b05d9a85d20','trk_aff5e3e7ca8a4247ae042a8f062096cf','https://track.easypost.com/djE6dHJrX2FmZjVlM2U3Y2E4YTQyNDdhZTA0MmE4ZjA2MjA5NmNm','in transit',NULL),(11,22,7,1,880,'shp_b5541868a49d48408518692defe6edc7','trk_aff5e3e7ca8a4247ae042a8f062096cf','https://track.easypost.com/djE6dHJrX2FmZjVlM2U3Y2E4YTQyNDdhZTA0MmE4ZjA2MjA5NmNm','in transit',NULL),(12,24,7,2,990,'shp_e0a8b7fe929547188301fcd9ded11dfd','trk_aff5e3e7ca8a4247ae042a8f062096cf','https://track.easypost.com/djE6dHJrX2FmZjVlM2U3Y2E4YTQyNDdhZTA0MmE4ZjA2MjA5NmNm','in transit',NULL),(13,20,8,2,1320,'Order Requested for return','trk_aff5e3e7ca8a4247ae042a8f062096cf','https://track.easypost.com/djE6dHJrX2FmZjVlM2U3Y2E4YTQyNDdhZTA0MmE4ZjA2MjA5NmNm','return requested','shp_b9e7be6b90fd47cfa30c1c075a3836d3'),(14,26,8,1,495,'shp_1c524245dbde49e4875a0d94267e241a','trk_aff5e3e7ca8a4247ae042a8f062096cf','https://track.easypost.com/djE6dHJrX2FmZjVlM2U3Y2E4YTQyNDdhZTA0MmE4ZjA2MjA5NmNm','in transit',NULL),(15,26,9,5,495,'shp_92348df015ce46cdbb58a18ff61fdde3','trk_aff5e3e7ca8a4247ae042a8f062096cf','https://track.easypost.com/djE6dHJrX2FmZjVlM2U3Y2E4YTQyNDdhZTA0MmE4ZjA2MjA5NmNm','in transit',NULL),(16,20,10,1,1320,'shp_cd8e12e996a441a3922aeaa7ec157c01','trk_aff5e3e7ca8a4247ae042a8f062096cf','https://track.easypost.com/djE6dHJrX2FmZjVlM2U3Y2E4YTQyNDdhZTA0MmE4ZjA2MjA5NmNm','in transit',NULL),(17,21,10,1,1760,'Order Requested for return','trk_aff5e3e7ca8a4247ae042a8f062096cf','https://track.easypost.com/djE6dHJrX2FmZjVlM2U3Y2E4YTQyNDdhZTA0MmE4ZjA2MjA5NmNm','return requested','shp_6dbdb2d70bc64749a1267374408907fa'),(18,22,10,1,880,'shp_6afba003c2b54019980e36ef4e53db91','trk_aff5e3e7ca8a4247ae042a8f062096cf','https://track.easypost.com/djE6dHJrX2FmZjVlM2U3Y2E4YTQyNDdhZTA0MmE4ZjA2MjA5NmNm','in transit',NULL),(19,23,10,1,616,'shp_fad0f0d3444e44e9ba4709278697a022','trk_aff5e3e7ca8a4247ae042a8f062096cf','https://track.easypost.com/djE6dHJrX2FmZjVlM2U3Y2E4YTQyNDdhZTA0MmE4ZjA2MjA5NmNm','in transit',NULL);
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
/*!40000 ALTER TABLE `otps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promocode`
--

DROP TABLE IF EXISTS `promocode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promocode` (
  `promocode` varchar(15) NOT NULL,
  `discount_percent` int(10) unsigned DEFAULT NULL,
  `max_discount` int(11) NOT NULL,
  `is_active` bit(1) NOT NULL,
  PRIMARY KEY (`promocode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promocode`
--

LOCK TABLES `promocode` WRITE;
/*!40000 ALTER TABLE `promocode` DISABLE KEYS */;
INSERT INTO `promocode` VALUES ('CODE100',20,100,_binary ''),('CODE123',20,100,_binary '\0'),('CODE12345',20,100,_binary ''),('CODE456',20,50,_binary ''),('CODE45678',20,50,_binary ''),('CODE50',20,50,_binary ''),('EASTER100',20,50,_binary ''),('HOLIDAYSPECIAL',20,50,_binary '');
/*!40000 ALTER TABLE `promocode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase`
--


--
-- Table structure for table `ref_catalog`
--

/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_catalog`
--



--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `reviewId` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(10) unsigned NOT NULL,
  `itemId` int(10) unsigned NOT NULL,
  `rating` enum('1','2','3','4','5') NOT NULL,
  `comments` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`reviewId`),
  KEY `userId` (`userId`),
  KEY `itemId` (`itemId`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `end_user` (`userId`),
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`itemId`) REFERENCES `ref_catalog` (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (13,79,74,'4','Amazing Item. Super Fast Charging!!!'),(14,80,74,'2','Did not like the product. Camera could have been better.');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `userId` int(10) unsigned NOT NULL,
  `ssn` int(11) DEFAULT NULL,
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
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stripe_user`
--

DROP TABLE IF EXISTS `stripe_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stripe_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `stripeCustomerId` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stripe_user`
--

LOCK TABLES `stripe_user` WRITE;
/*!40000 ALTER TABLE `stripe_user` DISABLE KEYS */;
INSERT INTO `stripe_user` VALUES (5,78,'cus_PAI3HRIzf2DEIC'),(6,79,'cus_PAIH6wFtyxiMbd'),(7,80,'cus_PAIY5F519BY8vf'),(8,75,'cus_PAIzBg2PZaU0es');
/*!40000 ALTER TABLE `stripe_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--
