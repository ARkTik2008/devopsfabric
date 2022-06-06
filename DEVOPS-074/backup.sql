-- MySQL dump 10.13  Distrib 8.0.29, for Linux (x86_64)
--
-- Host: localhost    Database: application
-- ------------------------------------------------------
-- Server version	8.0.29

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ap`
--

DROP TABLE IF EXISTS `ap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ap` (
  `contr_id` int NOT NULL,
  `apid` int NOT NULL,
  `boot_script` varchar(255) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `building` varchar(100) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `dataplan_encryption` varchar(100) DEFAULT NULL,
  `mac_address` varchar(20) DEFAULT NULL,
  `model` varchar(30) DEFAULT NULL,
  `power_suply` varchar(30) DEFAULT NULL,
  `config_id` int DEFAULT NULL,
  PRIMARY KEY (`contr_id`,`apid`),
  KEY `config_id` (`config_id`),
  CONSTRAINT `ap_ibfk_1` FOREIGN KEY (`contr_id`) REFERENCES `controller` (`contr_id`),
  CONSTRAINT `ap_ibfk_2` FOREIGN KEY (`config_id`) REFERENCES `text_configs` (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `controller`
--

DROP TABLE IF EXISTS `controller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `controller` (
  `contr_id` int NOT NULL,
  `name` varchar(40) DEFAULT NULL,
  `ipaddr` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`contr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `essap`
--

DROP TABLE IF EXISTS `essap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `essap` (
  `contr_id` int NOT NULL,
  `apid` int NOT NULL,
  `ifaceid` int NOT NULL,
  `essid` varchar(200) NOT NULL,
  `calls_per_bss` int DEFAULT NULL,
  `config_id` int DEFAULT NULL,
  PRIMARY KEY (`contr_id`,`apid`,`ifaceid`,`essid`),
  KEY `config_id` (`config_id`),
  CONSTRAINT `essap_ibfk_1` FOREIGN KEY (`contr_id`, `apid`, `ifaceid`) REFERENCES `interface` (`contr_id`, `apid`, `ifaceid`),
  CONSTRAINT `essap_ibfk_2` FOREIGN KEY (`config_id`) REFERENCES `text_configs` (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `interface`
--

DROP TABLE IF EXISTS `interface`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interface` (
  `contr_id` int NOT NULL,
  `apid` int NOT NULL,
  `ifaceid` int NOT NULL,
  `config_id` int DEFAULT NULL,
  `channel` varchar(4) DEFAULT NULL,
  `rf_mode` varchar(20) DEFAULT NULL,
  `localpower` varchar(5) DEFAULT NULL,
  `channel_width` varchar(20) DEFAULT NULL,
  `protection_cts_mode` varchar(20) DEFAULT NULL,
  `protection_mode` varchar(20) DEFAULT NULL,
  `virtual_cell_mode` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`contr_id`,`apid`,`ifaceid`),
  KEY `config_id` (`config_id`),
  CONSTRAINT `interface_ibfk_1` FOREIGN KEY (`contr_id`, `apid`) REFERENCES `ap` (`contr_id`, `apid`),
  CONSTRAINT `interface_ibfk_2` FOREIGN KEY (`config_id`) REFERENCES `text_configs` (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `text_configs`
--

DROP TABLE IF EXISTS `text_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `text_configs` (
  `config_id` int NOT NULL,
  `contr_id` int DEFAULT NULL,
  `orig_text` longtext,
  `download_ts` int DEFAULT NULL,
  `parsed_text` longtext,
  `orig_filename` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`config_id`),
  KEY `contr_id` (`contr_id`),
  CONSTRAINT `text_configs_ibfk_1` FOREIGN KEY (`contr_id`) REFERENCES `controller` (`contr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-06 14:41:02
