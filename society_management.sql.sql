-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: society_management
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `complaints`
--

DROP TABLE IF EXISTS `complaints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `complaints` (
  `complaint_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `flat_id` int DEFAULT NULL,
  `description` text,
  `priority` enum('low','medium','high') DEFAULT NULL,
  `status` enum('pending','in progress','resolved') DEFAULT NULL,
  `date_created` date DEFAULT NULL,
  `resolved_date` date DEFAULT NULL,
  PRIMARY KEY (`complaint_id`),
  KEY `user_id` (`user_id`),
  KEY `flat_id` (`flat_id`),
  CONSTRAINT `complaints_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `complaints_ibfk_2` FOREIGN KEY (`flat_id`) REFERENCES `flats` (`flat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complaints`
--

LOCK TABLES `complaints` WRITE;
/*!40000 ALTER TABLE `complaints` DISABLE KEYS */;
INSERT INTO `complaints` VALUES (1,2,1,'Water leakage issue','high','resolved','2026-03-15','2026-04-13'),(2,3,2,'Lift not working','medium','resolved','2026-03-16','2026-04-14'),(3,4,3,'Electricity fluctuation','high','resolved','2026-03-14','2026-03-16'),(4,5,4,'garbage not collected','medium','resolved','2026-04-13',NULL),(5,2,1,'Garbage issue','medium','resolved','2026-04-14','2026-04-15'),(8,2,1,'electricity','low','resolved','2026-04-26','2026-04-27'),(10,2,1,'Electricity','high','pending','2026-04-27',NULL);
/*!40000 ALTER TABLE `complaints` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `set_resolved_date_before_insert` BEFORE INSERT ON `complaints` FOR EACH ROW BEGIN
    IF NEW.status = 'resolved' THEN
        SET NEW.resolved_date = CURRENT_DATE;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `set_resolved_date_before_update` BEFORE UPDATE ON `complaints` FOR EACH ROW BEGIN
    IF NEW.status = 'resolved' THEN
        SET NEW.resolved_date = CURRENT_DATE;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `flat_allocation`
--

DROP TABLE IF EXISTS `flat_allocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flat_allocation` (
  `allocation_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `flat_id` int DEFAULT NULL,
  `type` enum('owner','tenant') DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`allocation_id`),
  KEY `user_id` (`user_id`),
  KEY `flat_id` (`flat_id`),
  CONSTRAINT `flat_allocation_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `flat_allocation_ibfk_2` FOREIGN KEY (`flat_id`) REFERENCES `flats` (`flat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flat_allocation`
--

LOCK TABLES `flat_allocation` WRITE;
/*!40000 ALTER TABLE `flat_allocation` DISABLE KEYS */;
INSERT INTO `flat_allocation` VALUES (1,2,1,'owner','2024-01-01',NULL),(2,3,2,'tenant','2024-02-01',NULL),(3,4,3,'owner','2024-03-01',NULL),(4,5,4,'tenant','2024-04-01',NULL),(5,11,6,'owner','2026-04-15','2026-04-26'),(6,13,5,'owner','2026-04-26',NULL),(7,15,6,'owner','2026-04-26',NULL),(8,14,7,'owner','2026-04-26',NULL);
/*!40000 ALTER TABLE `flat_allocation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flats`
--

DROP TABLE IF EXISTS `flats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flats` (
  `flat_id` int NOT NULL AUTO_INCREMENT,
  `block` varchar(10) DEFAULT NULL,
  `flat_number` varchar(10) DEFAULT NULL,
  `floor` int DEFAULT NULL,
  PRIMARY KEY (`flat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flats`
--

LOCK TABLES `flats` WRITE;
/*!40000 ALTER TABLE `flats` DISABLE KEYS */;
INSERT INTO `flats` VALUES (1,'A','101',1),(2,'A','102',1),(3,'B','201',2),(4,'B','202',2),(5,'B','302',3),(6,'A','402',4),(7,'A','401',4),(11,'B','101',1),(12,'B','102',1);
/*!40000 ALTER TABLE `flats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenance`
--

DROP TABLE IF EXISTS `maintenance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenance` (
  `maintenance_id` int NOT NULL AUTO_INCREMENT,
  `flat_id` int DEFAULT NULL,
  `month` int DEFAULT NULL,
  `year` int DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `late_fee` decimal(10,2) DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `generated_date` date DEFAULT NULL,
  `status` enum('paid','unpaid') DEFAULT NULL,
  PRIMARY KEY (`maintenance_id`),
  KEY `flat_id` (`flat_id`),
  CONSTRAINT `maintenance_ibfk_1` FOREIGN KEY (`flat_id`) REFERENCES `flats` (`flat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenance`
--

LOCK TABLES `maintenance` WRITE;
/*!40000 ALTER TABLE `maintenance` DISABLE KEYS */;
INSERT INTO `maintenance` VALUES (1,1,3,2026,2000.00,100.00,'2026-03-10','2026-03-01','paid'),(2,2,3,2026,1800.00,50.00,'2026-03-10','2026-03-01','paid'),(3,3,3,2026,2200.00,0.00,'2026-03-10','2026-03-01','paid'),(4,4,3,2026,2100.00,0.00,'2026-03-10','2026-03-01','paid'),(5,1,4,2026,3000.00,NULL,NULL,NULL,'paid'),(6,2,4,2026,3000.00,NULL,NULL,NULL,'unpaid'),(7,3,4,2026,3000.00,NULL,NULL,NULL,'unpaid'),(8,4,4,2026,3000.00,NULL,NULL,NULL,'paid'),(12,1,5,2026,3500.00,NULL,NULL,NULL,'unpaid'),(13,2,5,2026,3500.00,NULL,NULL,NULL,'unpaid'),(14,3,5,2026,3500.00,NULL,NULL,NULL,'unpaid'),(15,4,5,2026,3500.00,NULL,NULL,NULL,'unpaid'),(16,5,5,2026,3500.00,NULL,NULL,NULL,'unpaid');
/*!40000 ALTER TABLE `maintenance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `maintenance_id` int DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `amount_paid` decimal(10,2) DEFAULT NULL,
  `payment_mode` enum('cash','online') DEFAULT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `status` enum('success','failed') DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `maintenance_id` (`maintenance_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`maintenance_id`) REFERENCES `maintenance` (`maintenance_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,2,'2026-03-05',1800.00,'online','TXN12345','success'),(2,4,'2026-03-06',2100.00,'cash','TXN67890','success'),(3,1,'2026-04-14',2000.00,'online',NULL,'success'),(4,4,'2026-04-14',2100.00,'online',NULL,'success'),(5,3,'2026-04-14',2200.00,'online',NULL,'success'),(6,1,'2026-04-14',2000.00,'online',NULL,'success'),(7,5,'2026-04-14',3000.00,'online',NULL,'success'),(8,8,'2026-04-15',3000.00,'online',NULL,'success');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_maintenance_status` AFTER INSERT ON `payments` FOR EACH ROW BEGIN
    UPDATE maintenance
    SET status = 'paid'
    WHERE maintenance_id = NEW.maintenance_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staff_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `shift` varchar(50) DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `joining_date` date DEFAULT NULL,
  PRIMARY KEY (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'Ramesh','Security Guard','9000000001','Day',15000.00,'2023-01-10'),(2,'Suresh','Cleaner','9000000002','Morning',12000.00,'2023-02-15'),(3,'Mahesh','Electrician','9000000002','Day',18000.00,'2023-03-20'),(4,'Riya','Guard','6589689290','day',30000.00,'2026-04-15'),(6,'om','Electrician','3434343434','day',20000.00,'2026-04-27'),(7,'raj','cleaner','1236780000','day',15000.00,'2026-04-27'),(8,'rohit','chairman','8888822222','-',10000.00,'2026-04-27'),(9,'janvi','cashier','2222288888','-',10000.00,'2026-04-27'),(10,'mansi','cleaner','5454545454','day',10000.00,'2026-04-27');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `role` enum('admin','resident') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_active` tinyint(1) DEFAULT '1',
  `approval_status` varchar(20) DEFAULT 'approved',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin','admin@gmail.com','9999999999','admin123','admin','2026-04-05 12:48:20',1,'approved'),(2,'Rahul Sharma','rahul@gmail.com','9876543212','rahul1234','resident','2026-04-05 12:48:20',1,'approved'),(3,'Priya Mehta','priya@gmail.com','9123456780','priya123','resident','2026-04-05 12:48:20',1,'approved'),(4,'Amit Patil','amit@gmail.com','9012345678','amit123','resident','2026-04-05 12:48:20',1,'approved'),(5,'Sneha Joshi','sneha@gmail.com','9988776655','sneha123','resident','2026-04-05 12:48:20',1,'approved'),(8,'Ishwari','ishwari0306@gmail.com','1234567890','ish123','resident','2026-04-13 16:18:58',1,'approved'),(9,'test','test@gmail.com',NULL,NULL,'resident','2026-04-13 16:22:50',0,'approved'),(10,'Siddiqa','siddiqa@gmail.com','8856958794','sid05','resident','2026-04-14 14:52:34',1,'approved'),(11,'Anushka','anushka@gmail.com','8725719311','abcd123','resident','2026-04-15 06:14:42',1,'approved'),(12,'123@abc','nehagmail.com','abcd','1234','resident','2026-04-20 06:51:11',0,'approved'),(13,'sakshi','sak@gmail.com','1236547890','666666','resident','2026-04-24 09:36:15',1,'approved'),(14,'prachi','prachi@gmail.com','5432109876','prachi123','resident','2026-04-26 11:33:51',1,'approved'),(15,'shreya','shreya@gmail.com','1234512345','shreya123','resident','2026-04-26 11:55:31',1,'approved'),(16,'shruti','shruti@gmail.com','4444412345','shruti123','resident','2026-04-26 12:12:56',1,'approved');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'society_management'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_maintenance` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_maintenance`(
    IN f_id INT,
    IN amt DECIMAL(10,2)
)
BEGIN
    INSERT INTO maintenance (flat_id, month, year, amount, status)
    VALUES (f_id, MONTH(CURDATE()), YEAR(CURDATE()), amt, 'unpaid');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `approve_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `approve_user`(
    IN p_user_id INT
)
BEGIN
    UPDATE users
    SET approval_status = 'approved',
        is_active = 1
    WHERE user_id = p_user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `assign_flat` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `assign_flat`(
    IN p_user_id INT,
    IN p_flat_id INT,
    IN p_type VARCHAR(20)
)
BEGIN
    
    UPDATE flat_allocation
    SET end_date = CURDATE()
    WHERE flat_id = p_flat_id AND end_date IS NULL;

    
    INSERT INTO flat_allocation (user_id, flat_id, type, start_date)
    VALUES (p_user_id, p_flat_id, p_type, CURDATE());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_unpaid_maintenance` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_unpaid_maintenance`()
BEGIN
    SELECT * 
    FROM maintenance
    WHERE status = 'unpaid';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `resolve_complaint` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `resolve_complaint`(
    IN p_complaint_id INT
)
BEGIN
    UPDATE complaints
    SET status = 'resolved'
    WHERE complaint_id = p_complaint_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-31 21:11:33
