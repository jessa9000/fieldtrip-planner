-- All these 40101 SET variable assignments look important so I'll leave them here for now

-- MySQL dump 10.16  Distrib 10.1.37-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: bsg
-- ------------------------------------------------------
-- Server version	10.1.37-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Students`
--

DROP TABLE IF EXISTS `Students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Students` (
  `studentID` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(255) NOT NULL,
  `lastName` VARCHAR(255),
  `schoolYear` YEAR NOT NULL,
  `allergiesFlag` BOOLEAN DEFAULT 0,
  `specialPower` VARCHAR(255),
  PRIMARY KEY (`studentID`),
  UNIQUE KEY (`studentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Students`
--

LOCK TABLES `Students` WRITE;
/*!40000 ALTER TABLE `Students` DISABLE KEYS */;
INSERT INTO `Students` VALUES
  (1, 'Rutabaga', 'Jones', 2021, 0, 'Levitation'),
  (2, 'Alexander', 'Nguyen', 2021, 1, 'Talking to Bears'),
  (3, 'Jack-Jack', 'Parr', 2021, 1, 'All the Powers');
/*!40000 ALTER TABLE `Students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TrustedAdults`
--

DROP TABLE IF EXISTS `TrustedAdults`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TrustedAdults` (
  `adultID` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(255) NOT NULL,
  `lastName` VARCHAR(255) NOT NULL,
  `primaryPhone` CHAR(10) NOT NULL,
  PRIMARY KEY (`adultID`),
  UNIQUE KEY (`adultID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TrustedAdults`
--

LOCK TABLES `TrustedAdults` WRITE;
/*!40000 ALTER TABLE `TrustedAdults` DISABLE KEYS */;
INSERT INTO `TrustedAdults` VALUES
  (1, 'Daphne', 'Jones', '4105551000'),
  (2, 'Huy', 'Nguyen', '4101115000'),
  (3, 'An', 'Nguyen', '4101115001'),
  (4, 'Helen', 'Parr', '8663719297');
/*!40000 ALTER TABLE `TrustedAdults` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Trips`
--

DROP TABLE IF EXISTS `Trips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Trips` (
  `tripID` INT NOT NULL AUTO_INCREMENT UNIQUE,
  `name` VARCHAR(255) NOT NULL,
  `street` VARCHAR(255) NOT NULL,
  `city` VARCHAR(255) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `zipCode` CHAR(5) NOT NULL,
  `date` DATE NOT NULL,
  `meetTime` TIME,
  `returnTime` TIME,
  PRIMARY KEY (`tripID`),
  UNIQUE KEY (`tripID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Trips`
--

LOCK TABLES `Trips` WRITE;
/*!40000 ALTER TABLE `Trips` DISABLE KEYS */;
INSERT INTO `Trips` VALUES
  (1, 'The Mutter Museum', '19 S 22nd St', 'Philadelphia', 'PA', '19103', "2022-10-31", '10:00:00', '15:00:00'),
  (2, 'The President Woodrow Wilson House', '2340 S St NW', 'Washington', 'DC', '20008', "2022-11-11", '9:00:00', '12:00:00'),
  (3, 'Fern Hill Park', '1000 Western Highway', 'Newark', 'DE', '19711', "2022-03-14", '9:00:00', '15:00:00');
/*!40000 ALTER TABLE `Trips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Snacks`
--

DROP TABLE IF EXISTS `Snacks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Snacks` (
  `snackID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`snackID`),
  UNIQUE KEY (`snackID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Snacks`
--

LOCK TABLES `Snacks` WRITE;
/*!40000 ALTER TABLE `Snacks` DISABLE KEYS */;
INSERT INTO `Snacks` VALUES
  (1, 'Trail Mix'),
  (2, 'Shrimp Crackers'),
  (3, 'Apple Slices'),
  (4, 'Pudding');
/*!40000 ALTER TABLE `Snacks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Allergens`
--

DROP TABLE IF EXISTS `Allergens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Allergens` (
  `allergenID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`allergenID`),
  UNIQUE KEY (`allergenID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Allergens`
--

LOCK TABLES `Allergens` WRITE;
/*!40000 ALTER TABLE `Allergens` DISABLE KEYS */;
INSERT INTO `Allergens` VALUES
  (1, 'Milk'),
  (2, 'Eggs'),
  (3, 'Fish'),
  (4, 'Shellfish'),
  (5, 'Tree Nuts'),
  (6, 'Peanuts'),
  (7, 'Wheat'),
  (8, 'Soybeans');
/*!40000 ALTER TABLE `Allergens` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

--
-- Table structure for table `Attendees`
-- RESTRICT for deletion of studentID and adultID FKs
-- CASCADE for deletion of tripID FK
--

DROP TABLE IF EXISTS `Attendees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Attendees` (
  `studentID` INT NOT NULL,
  `tripID` INT NOT NULL,
  `adultID` INT,
  PRIMARY KEY (`studentID`, `tripID`),
  CONSTRAINT `AttendeesStudentsFK` FOREIGN KEY (`studentID`) REFERENCES `Students` (`studentID`) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT `AttendeesTripsFK` FOREIGN KEY (`tripID`) REFERENCES `Trips` (`tripID`) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `AttendeesTrustedAdultsFK` FOREIGN KEY (`adultID`) REFERENCES `TrustedAdults` (`adultID`) ON UPDATE CASCADE ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Attendees`
--

LOCK TABLES `Attendees` WRITE;
/*!40000 ALTER TABLE `Attendees` DISABLE KEYS */;
INSERT INTO `Attendees` VALUES
  (1, 2, 3),
  (2, 2, 3),
  (4, 1, 3);
/*!40000 ALTER TABLE `Attendees` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

--
-- Table structure for table `PlannedSnacks`
-- SET NULL for deletion of snackID and adultID FKs
-- CASCADE for deletion of tripID FK
--

DROP TABLE IF EXISTS `PlannedSnacks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PlannedSnacks` (
  `plannedSnackID` INT NOT NULL AUTO_INCREMENT UNIQUE,
  `snackID` INT,
  `tripID` INT NOT NULL,
  `adultID` INT,
  PRIMARY KEY (`plannedSnackID`),
  UNIQUE KEY (`plannedSnackID`),
  CONSTRAINT `PlannedSnacksSnacksFK` FOREIGN KEY (`snackID`) REFERENCES `Snacks` (`snackID`) ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT `PlannedSnacksTripsFK` FOREIGN KEY (`tripID`) REFERENCES `Trips` (`tripID`) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `PlannedSnacksTrustedAdultsFK` FOREIGN KEY (`adultID`) REFERENCES `TrustedAdults` (`adultID`) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PlannedSnacks`
--

LOCK TABLES `PlannedSnacks` WRITE;
/*!40000 ALTER TABLE `PlannedSnacks` DISABLE KEYS */;
INSERT INTO `PlannedSnacks` VALUES
  (1, 1, 2, 3),
  (2, 4, 2, 3),
  (3, 2, 1, 3);
/*!40000 ALTER TABLE `PlannedSnacks` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

--
-- Table structure for table `Allergies`
-- CASCADE for deletion of studentID and allergenID FKs
-- 

DROP TABLE IF EXISTS `Allergies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Allergies` (
  `studentID` INT NOT NULL,
  `allergenID` INT NOT NULL,
  PRIMARY KEY (`studentID`, `allergenID`),
  CONSTRAINT `AllergiesStudentsFK` FOREIGN KEY (`studentID`) REFERENCES `Students` (`studentID`) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `AllergiesAllergensFK` FOREIGN KEY (`allergenID`) REFERENCES `Allergens` (`allergenID`) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Allergies`
--

LOCK TABLES `Allergies` WRITE;
/*!40000 ALTER TABLE `Allergies` DISABLE KEYS */;
INSERT INTO `Allergies` VALUES
  (2, 5),
  (2, 8),
  (3, 5);
/*!40000 ALTER TABLE `Allergies` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

--
-- Table structure for table `Ingredients`
-- CASCADE for deletion of snackID and allergenID FKs
--

DROP TABLE IF EXISTS `Ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ingredients` (
  `snackID` INT NOT NULL,
  `allergenID` INT NOT NULL,
  PRIMARY KEY (`snackID`, `allergenID`),
  CONSTRAINT `IngredientsSnacksFK` FOREIGN KEY (`snackID`) REFERENCES `Snacks` (`snackID`) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `IngredientsAllergensFK` FOREIGN KEY (`allergenID`) REFERENCES `Allergens` (`allergenID`) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ingredients`
--

LOCK TABLES `Ingredients` WRITE;
/*!40000 ALTER TABLE `Ingredients` DISABLE KEYS */;
INSERT INTO `Ingredients` VALUES
  (1, 5),
  (2, 4),
  (2, 7);
/*!40000 ALTER TABLE `Ingredients` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

--
-- Table structure for table `EmergencyContacts`
-- RESTRICT for deletion of studentID and adultID FKs
-- 

DROP TABLE IF EXISTS `EmergencyContacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EmergencyContacts` (
  `studentID` INT NOT NULL,
  `adultID` INT NOT NULL,
  PRIMARY KEY (`studentID`, `adultID`),
  CONSTRAINT `EmergencyContactsStudentsFK` FOREIGN KEY (`studentID`) REFERENCES `Students` (`studentID`) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `EmergencyContactsTrustedAdultsFK` FOREIGN KEY (`adultID`) REFERENCES `TrustedAdults` (`adultID`) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EmergencyContacts`
--

LOCK TABLES `EmergencyContacts` WRITE;
/*!40000 ALTER TABLE `EmergencyContacts` DISABLE KEYS */;
INSERT INTO `EmergencyContacts` VALUES
  (1, 1),
  (2, 2),
  (2, 3),
  (3, 4);
/*!40000 ALTER TABLE `EmergencyContacts` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-02-03  0:38:33
