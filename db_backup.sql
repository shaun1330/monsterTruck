-- MySQL dump 10.13  Distrib 8.0.16, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.16

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `mydb`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `mydb` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `mydb`;

--
-- Table structure for table `bank_detail`
--

DROP TABLE IF EXISTS `bank_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `bank_detail` (
  `bsb` varchar(15) NOT NULL,
  `account_no` varchar(15) NOT NULL,
  `bank_name` varchar(45) NOT NULL,
  `customer_name` varchar(45) NOT NULL,
  PRIMARY KEY (`bsb`,`account_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_detail`
--

LOCK TABLES `bank_detail` WRITE;
/*!40000 ALTER TABLE `bank_detail` DISABLE KEYS */;
INSERT INTO `bank_detail` VALUES ('33120','283739','Westpac Bank','Greater Western 4x4 Club');
/*!40000 ALTER TABLE `bank_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expense`
--

DROP TABLE IF EXISTS `expense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `expense` (
  `expense_id` int(11) NOT NULL,
  `expense_description` varchar(45) NOT NULL,
  PRIMARY KEY (`expense_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expense`
--

LOCK TABLES `expense` WRITE;
/*!40000 ALTER TABLE `expense` DISABLE KEYS */;
INSERT INTO `expense` VALUES (1,'Admin'),(2,'Insurance');
/*!40000 ALTER TABLE `expense` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expense_line`
--

DROP TABLE IF EXISTS `expense_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `expense_line` (
  `expense_id` int(11) NOT NULL,
  `expense_receipt_no` int(11) NOT NULL,
  `line_cash_amount` decimal(9,2) NOT NULL,
  `line_transfer_amount` decimal(9,2) NOT NULL,
  `expense_note` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`expense_id`,`expense_receipt_no`),
  KEY `fk_expense_line_expense_receipt1` (`expense_receipt_no`),
  CONSTRAINT `fk_expense_line_expense1` FOREIGN KEY (`expense_id`) REFERENCES `expense` (`expense_id`),
  CONSTRAINT `fk_expense_line_expense_receipt1` FOREIGN KEY (`expense_receipt_no`) REFERENCES `expense_receipt` (`expense_receipt_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expense_line`
--

LOCK TABLES `expense_line` WRITE;
/*!40000 ALTER TABLE `expense_line` DISABLE KEYS */;
INSERT INTO `expense_line` VALUES (999,70000,0.00,0.00,'Database initialisation transaction');
/*!40000 ALTER TABLE `expense_line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expense_receipt`
--

DROP TABLE IF EXISTS `expense_receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `expense_receipt` (
  `expense_receipt_no` int(11) NOT NULL,
  `expense_id` int(11) NOT NULL,
  `cash_amount` decimal(9,2) NOT NULL,
  `transfer_amount` decimal(9,2) NOT NULL,
  `payment_datetime` datetime NOT NULL,
  `expense_notes` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`expense_receipt_no`),
  KEY `fk_expense1` (`expense_id`),
  CONSTRAINT `fk_expense1` FOREIGN KEY (`expense_id`) REFERENCES `expense` (`expense_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expense_receipt`
--

LOCK TABLES `expense_receipt` WRITE;
/*!40000 ALTER TABLE `expense_receipt` DISABLE KEYS */;
INSERT INTO `expense_receipt` VALUES (70000,1,0.00,0.00,'1970-01-01 00:00:00','Database initalisation'),(70001,2,0.00,-100.00,'2020-01-04 15:37:19','\n');
/*!40000 ALTER TABLE `expense_receipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `income`
--

DROP TABLE IF EXISTS `income`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `income` (
  `income_id` int(11) NOT NULL,
  `income_description` varchar(45) NOT NULL,
  PRIMARY KEY (`income_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `income`
--

LOCK TABLES `income` WRITE;
/*!40000 ALTER TABLE `income` DISABLE KEYS */;
INSERT INTO `income` VALUES (1,'Admin'),(2,'Interest');
/*!40000 ALTER TABLE `income` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `income_receipt`
--

DROP TABLE IF EXISTS `income_receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `income_receipt` (
  `income_receipt_no` int(11) NOT NULL,
  `income_id` int(11) NOT NULL,
  `cash_amount` decimal(9,2) NOT NULL,
  `transfer_amount` decimal(9,2) NOT NULL,
  `payment_datetime` datetime NOT NULL,
  `income_notes` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`income_receipt_no`),
  KEY `fk_income1` (`income_id`),
  CONSTRAINT `fk_income1` FOREIGN KEY (`income_id`) REFERENCES `income` (`income_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `income_receipt`
--

LOCK TABLES `income_receipt` WRITE;
/*!40000 ALTER TABLE `income_receipt` DISABLE KEYS */;
INSERT INTO `income_receipt` VALUES (30000,1,50.45,2504.48,'1970-01-01 00:00:00','Database initalisation'),(30001,2,0.00,2.00,'2017-11-07 00:00:00','\n');
/*!40000 ALTER TABLE `income_receipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `invoice` (
  `invoice_no` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_date` datetime NOT NULL,
  `invoice_duedate` datetime NOT NULL,
  `invoice_total` decimal(9,2) NOT NULL,
  `member_no` int(11) NOT NULL,
  `invoice_sent` varchar(3) NOT NULL,
  PRIMARY KEY (`invoice_no`),
  KEY `fk_invoice_member` (`member_no`),
  CONSTRAINT `fk_invoice_member` FOREIGN KEY (`member_no`) REFERENCES `member` (`member_no`)
) ENGINE=InnoDB AUTO_INCREMENT=10003 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
INSERT INTO `invoice` VALUES (10000,'1970-01-01 00:00:00','1970-01-01 00:00:00',0.00,1,'Yes'),(10001,'2020-01-04 15:49:47','2020-05-20 00:00:00',100.00,19,'No'),(10002,'2020-01-04 20:42:47','2020-01-04 00:00:00',10.00,2,'Yes');
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_line`
--

DROP TABLE IF EXISTS `invoice_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `invoice_line` (
  `invoice_no` int(11) NOT NULL,
  `item_qty` int(11) NOT NULL,
  `invoice_item_value` decimal(9,2) NOT NULL,
  `item_code` int(11) NOT NULL,
  PRIMARY KEY (`invoice_no`,`item_code`),
  KEY `fk_invoice_line_item1` (`item_code`),
  CONSTRAINT `fk_invoice_line_invoice1` FOREIGN KEY (`invoice_no`) REFERENCES `invoice` (`invoice_no`),
  CONSTRAINT `fk_invoice_line_item1` FOREIGN KEY (`item_code`) REFERENCES `item` (`item_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_line`
--

LOCK TABLES `invoice_line` WRITE;
/*!40000 ALTER TABLE `invoice_line` DISABLE KEYS */;
INSERT INTO `invoice_line` VALUES (10001,1,100.00,1),(10002,1,10.00,2);
/*!40000 ALTER TABLE `invoice_line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_receipt`
--

DROP TABLE IF EXISTS `invoice_receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `invoice_receipt` (
  `invoice_receipt_no` int(11) NOT NULL,
  `invoice_no` int(11) NOT NULL,
  `cash_amount` decimal(9,2) NOT NULL,
  `transfer_amount` decimal(9,2) NOT NULL,
  `payment_datetime` datetime NOT NULL,
  `receipt_sent` varchar(3) NOT NULL,
  PRIMARY KEY (`invoice_receipt_no`),
  UNIQUE KEY `invoice_no_UNIQUE` (`invoice_no`),
  CONSTRAINT `fk_receipt_invoice1` FOREIGN KEY (`invoice_no`) REFERENCES `invoice` (`invoice_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_receipt`
--

LOCK TABLES `invoice_receipt` WRITE;
/*!40000 ALTER TABLE `invoice_receipt` DISABLE KEYS */;
INSERT INTO `invoice_receipt` VALUES (40000,10000,0.00,0.00,'2020-01-04 15:36:39','Yes'),(40001,10001,0.00,100.00,'2019-12-03 00:00:00','No');
/*!40000 ALTER TABLE `invoice_receipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `item` (
  `item_code` int(11) NOT NULL,
  `item_description` varchar(45) NOT NULL,
  `item_value` decimal(9,2) NOT NULL,
  PRIMARY KEY (`item_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (1,'Annual Membership Renewal Fee',100.00),(2,'Fine',10.00),(3,'First Time Membership Fee',100.00),(4,'Club Apparel',50.00);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `member` (
  `member_no` int(11) NOT NULL AUTO_INCREMENT,
  `member_fname` varchar(45) NOT NULL,
  `member_lname` varchar(45) NOT NULL,
  `partner_name` varchar(45) DEFAULT NULL,
  `street_address` varchar(45) DEFAULT NULL,
  `suburb` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `postcode` varchar(45) DEFAULT NULL,
  `home_phone` varchar(45) DEFAULT NULL,
  `mobile_phone` varchar(45) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `member_status` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`member_no`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,'Admin','Admin','Admin','Admin','Admin','Admin','Admin','Admin','Admin','Admin','Admin'),(2,'Henk','Piper','Michelle Piper','9 Stawell Street','ROMSEY','VIC','3434',NULL,'0401 003 835','hmpiper@bigpond.com','ACTIVE'),(4,'Jim','Mizzi','Seiggi Mizzi','7 Camden Way','WYNDHAM VALE','VIC','3024',NULL,'0408 975 058','jim_mizzi@bigpond.com','ACTIVE'),(6,'Michael','Calleja','Sandra Calleja','20 Runnymeade Lane','BROOKFIELD','VIC','3338',NULL,'0418 516 040','miccalle@bigpond.net.au','ACTIVE'),(7,'Paul','Vassallo','Dawn Vassallo','92 Hallots Way','BACCHUS MARSH','VIC','3340',NULL,'0407 125 520','paul.vassallo2@bigpond.com','ACTIVE'),(8,'David','Sinai','Jenny Broadbent','101 Rutherford Road','VIEWBANK','VIC','3084',NULL,'0438 548 748','sinais@optusnet.com.au','ACTIVE'),(9,'Darren','Meyer','Rachel Takats','PO Box 463','YARRAVILLE','VIC','3013',NULL,'0411 030 055','dazm_70@yahoo.com.au','ACTIVE'),(10,'Richard','Lewis','Karen Lewais','355 Morrisons Lane','KOROBEIT','VIC','3341','5368 7390',NULL,'richard.lewis@qenos.com','ACTIVE'),(12,'Andrew','Willard','Jodie','23 Statesman Drive','KURUNJANG','VIC','3337',NULL,'0422 102 588','andrew.willard3337@gmail.com','ACTIVE'),(14,'Daniel','Turok','Louise Turok','18 Jinker Way','ROMSEY','VIC','3434',NULL,'0455 772 000','d.turok@yahoo.com.au','ACTIVE'),(15,'Victor','Turok','Blanche','16 Jinker Way','ROMSEY','VIC','3434',NULL,'0421 707 613','blanche6@dodo.com.au','ACTIVE'),(18,'Sunil','Chand','Ashrin Chand','9 Gainsford Way','BURNSIDE','VIC','3023',NULL,'0401 087 351','allubaigan@gmail.com','ACTIVE'),(19,'Steven','Simons','Mandy Simons','15 Willandra Court','TAYLORS LAKES','VIC','3038',NULL,'0439 991 353','steven72@iprimus.com.au','ACTIVE'),(24,'Ray','Vassallo',NULL,'7 Kensei Street','KURUNJANG','VIC','3337',NULL,'0418 176 223','rayvass_69@hotmail.com','ACTIVE'),(26,'Steve','Shanahan','Leonie Brownbill','11 Showlers Lane','LANCEFIELD','VIC','3435',NULL,'0407 127 236','s.shanahan@hotmail.com','ACTIVE'),(36,'Darren','Farrugia','Emma Day','66 East Street','WOODEND','VIC','3442',NULL,'0421 223 755','dfarrugia@live.co.uk','ACTIVE'),(38,'Brenton','Wynen','Lisa Wynen','16 Lady Penrhyn Drive','WYNDHAM VALE','VIC','3024',NULL,'0411 260 384','brenton.wynen@me.com','ACTIVE'),(39,'James','Gannaway','Melissa Patrick','4 Jacqueline Close','WERRIBBEE','VIC','3030',NULL,'0421 547 264','jammez_15@hotmail.com','ACTIVE'),(40,'Charlie','Cutajar','Tracey Bradley','90 Joan Street','SUNSHINE WEST','VIC','3020',NULL,'0423 044 220','cutajar.ca@gmail.com','ACTIVE'),(41,'Harsha','Sri','Reni Sri','1/20 Montasell Avenue','DEER PARK','VIC','3023',NULL,'0401 207 407','harshaoz79@yahoo.com.au','ACTIVE'),(43,'Alex','Carmichael',NULL,'42 Carlyon Close','MELTON WEST','VIC','3337',NULL,'0423 152 510','alxc67@gmail.com','ACTIVE'),(45,'Aaron','Harrison','Maddisen McKezie','15 Gildan Court','HOPPER CROSSING','VIC','3029',NULL,'0408 704 159','aaron_harrison88@hotmail.com','ACTIVE'),(48,'Costa','Kremastas',NULL,'3 Harsburg Court','TAYLORS LAKES','VIC','3038',NULL,'0413 161 162','ckremastas@gmail.com','ACTIVE'),(49,'Nick','Longo',NULL,'30 Quick Street','PASCOE VALE','VIC','3044',NULL,'0410 339 444','nick@relevantfinancial.com.au','ACTIVE'),(50,'Dean','Kirk','Melissa Gillin','11 Dundee Close','GLADSTONE PARK','VIC','3043',NULL,'0419 566 567','captain72@dodo.com.au','ACTIVE'),(51,'Barry','O\'Brien',NULL,'11 Columbia Circuit','BROADMEADOWS','VIC','3047',NULL,'0412 606 638','truckiebaz@gmail.com','ACTIVE'),(52,'Kerryn','Prior','Bron Prior','320 Gap Road','SUNBURY','VIC','3429',NULL,'0427 134 047','brokerbrumbys@live.com.au','ACTIVE'),(53,'Patrick','Honeyborne',NULL,'16 Solent Crescent','TAYLORS LAKES','VIC','3038',NULL,'0409 706 878','patrick@honeyborne.com.au','ACTIVE'),(55,'Peter','Jenner','Linda Chase','PO Box 55','KYNETON','VIC','3444',NULL,'0417 598 029','JENACE@SKYMESH.COM.AU','ACTIVE'),(56,'Paul','Oliver','Marcy Oliver','14 Clydesdale Way','SUNBURY','VIC','3429','9744 1572','0459 559 956','tjbj.oliver@bigpond.com','ACTIVE'),(57,'Chris','Delos',NULL,'8 Parrakeet Crescent','TAYLORS LAKES','VIC','3038','9449 4499','0430 145 934','cdelos@hotmail.com','ACTIVE');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `members` (
  `member_no` int(11) NOT NULL AUTO_INCREMENT,
  `member_fname` varchar(45) NOT NULL,
  `member_lname` varchar(45) NOT NULL,
  `partner_name` varchar(45) DEFAULT NULL,
  `street_address` varchar(45) DEFAULT NULL,
  `suburb` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `postcode` varchar(45) DEFAULT NULL,
  `home_phone` varchar(45) DEFAULT NULL,
  `mobile_phone` varchar(45) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `member_status` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`member_no`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
INSERT INTO `members` VALUES (1,'Shaun','Simons','Emma','','','','','','','shaunsimons93@gmail.com','ACTIVE'),(2,'Shaun','Simons','','','','','','','','shaunsimons93@gmail.com','ACTIVE');
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_history`
--

DROP TABLE IF EXISTS `payment_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `payment_history` (
  `n` int(11) NOT NULL DEFAULT '0',
  `payment_datetime` datetime NOT NULL,
  `cash_amount` decimal(9,2) NOT NULL DEFAULT '0.00',
  `transfer_amount` decimal(9,2) NOT NULL DEFAULT '0.00',
  `cash_balance` decimal(22,2) DEFAULT NULL,
  `bank_balance` decimal(22,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_history`
--

LOCK TABLES `payment_history` WRITE;
/*!40000 ALTER TABLE `payment_history` DISABLE KEYS */;
INSERT INTO `payment_history` VALUES (30000,'1970-01-01 00:00:00',50.45,2504.48,50.45,2504.48),(30001,'2017-11-07 00:00:00',0.00,2.00,50.45,2506.48),(40001,'2019-12-03 00:00:00',0.00,100.00,50.45,2606.48),(70001,'2020-01-04 15:37:19',0.00,-100.00,50.45,2506.48),(50001,'2020-01-04 19:58:15',-20.00,20.00,30.45,2526.48);
/*!40000 ALTER TABLE `payment_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receipt`
--

DROP TABLE IF EXISTS `receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `receipt` (
  `invoice_receipt_no` int(11) NOT NULL,
  `invoice_no` int(11) NOT NULL,
  `cash_amount` decimal(9,2) NOT NULL,
  `transfer_amount` decimal(9,2) NOT NULL,
  `payment_datetime` datetime NOT NULL,
  PRIMARY KEY (`invoice_receipt_no`),
  UNIQUE KEY `invoice_no_unique` (`invoice_no`),
  KEY `fk_receipt_invoice1_idx` (`invoice_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receipt`
--

LOCK TABLES `receipt` WRITE;
/*!40000 ALTER TABLE `receipt` DISABLE KEYS */;
/*!40000 ALTER TABLE `receipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_history`
--

DROP TABLE IF EXISTS `transaction_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `transaction_history` (
  `payment_datetime` datetime NOT NULL,
  `payment_cash_amount` decimal(9,2) NOT NULL,
  `payment_transfer_amount` decimal(9,2) NOT NULL,
  `cash_balance` decimal(9,2) NOT NULL,
  `transfer_amount` decimal(9,2) NOT NULL,
  PRIMARY KEY (`payment_datetime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_history`
--

LOCK TABLES `transaction_history` WRITE;
/*!40000 ALTER TABLE `transaction_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transfer`
--

DROP TABLE IF EXISTS `transfer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `transfer` (
  `transfer_no` int(11) NOT NULL,
  `cash_amount` decimal(9,2) NOT NULL,
  `transfer_amount` decimal(9,2) NOT NULL,
  `payment_datetime` datetime NOT NULL,
  PRIMARY KEY (`transfer_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transfer`
--

LOCK TABLES `transfer` WRITE;
/*!40000 ALTER TABLE `transfer` DISABLE KEYS */;
INSERT INTO `transfer` VALUES (50000,0.00,0.00,'1970-01-01 00:00:00'),(50001,-20.00,20.00,'2020-01-04 19:58:15');
/*!40000 ALTER TABLE `transfer` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-02-04 16:02:01
