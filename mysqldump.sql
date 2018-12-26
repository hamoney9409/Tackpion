-- MySQL dump 10.13  Distrib 8.0.13, for Linux (x86_64)
--
-- Host: localhost    Database: tackpion
-- ------------------------------------------------------
-- Server version	8.0.13

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
-- Current Database: `tackpion`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `tackpion` /*!40100 DEFAULT CHARACTER SET utf16 */;

USE `tackpion`;

--
-- Table structure for table `ADMIN`
--

DROP TABLE IF EXISTS `ADMIN`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ADMIN` (
  `id` varchar(40) NOT NULL,
  `password` varchar(64) DEFAULT NULL,
  `classid` int(11) NOT NULL AUTO_INCREMENT,
  `privileges` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`classid`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf16;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ADMIN`
--

LOCK TABLES `ADMIN` WRITE;
/*!40000 ALTER TABLE `ADMIN` DISABLE KEYS */;
INSERT INTO `ADMIN` VALUES ('hamoney9409','admin',1,1),('fjvbn2003','admin',2,1);
/*!40000 ALTER TABLE `ADMIN` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GAME`
--

DROP TABLE IF EXISTS `GAME`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `GAME` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player1` int(11) NOT NULL,
  `player2` int(11) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `score1_p1` int(2) DEFAULT NULL,
  `score1_p2` int(2) DEFAULT NULL,
  `score2_p1` int(2) DEFAULT NULL,
  `score2_p2` int(2) DEFAULT NULL,
  `score3_p1` int(2) DEFAULT NULL,
  `score3_p2` int(2) DEFAULT NULL,
  `score4_p1` int(2) DEFAULT NULL,
  `score4_p2` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `is_playing_idx` (`player1`,`player2`),
  KEY `is_playing2_idx` (`player2`),
  CONSTRAINT `is_playing1` FOREIGN KEY (`player1`) REFERENCES `PLAYER` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `is_playing2` FOREIGN KEY (`player2`) REFERENCES `PLAYER` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf16;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GAME`
--

LOCK TABLES `GAME` WRITE;
/*!40000 ALTER TABLE `GAME` DISABLE KEYS */;
INSERT INTO `GAME` VALUES (1,1,2,'2018-12-25 13:11:22',NULL,3,8,4,7,5,6,6,5);
/*!40000 ALTER TABLE `GAME` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PLAYER`
--

DROP TABLE IF EXISTS `PLAYER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `PLAYER` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) DEFAULT NULL,
  `teamid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `belong_to_idx` (`teamid`),
  CONSTRAINT `belong_to` FOREIGN KEY (`teamid`) REFERENCES `TEAM` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf16;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PLAYER`
--

LOCK TABLES `PLAYER` WRITE;
/*!40000 ALTER TABLE `PLAYER` DISABLE KEYS */;
INSERT INTO `PLAYER` VALUES (1,'하상범',1),(2,'김영주',1);
/*!40000 ALTER TABLE `PLAYER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SCORE_LOG`
--

DROP TABLE IF EXISTS `SCORE_LOG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `SCORE_LOG` (
  `set` int(2) NOT NULL,
  `number` int(2) NOT NULL,
  `score1` int(2) NOT NULL,
  `score2` int(2) NOT NULL,
  `date` datetime NOT NULL,
  `recorder_admin` int(11) DEFAULT NULL,
  `game_id` int(11) DEFAULT NULL,
  KEY `is_scorelog_of_idx` (`game_id`),
  KEY `is_recording` (`recorder_admin`),
  CONSTRAINT `is_recording` FOREIGN KEY (`recorder_admin`) REFERENCES `ADMIN` (`classid`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `is_scorelog_of` FOREIGN KEY (`game_id`) REFERENCES `GAME` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf16;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SCORE_LOG`
--

LOCK TABLES `SCORE_LOG` WRITE;
/*!40000 ALTER TABLE `SCORE_LOG` DISABLE KEYS */;
/*!40000 ALTER TABLE `SCORE_LOG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TEAM`
--

DROP TABLE IF EXISTS `TEAM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `TEAM` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf16;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TEAM`
--

LOCK TABLES `TEAM` WRITE;
/*!40000 ALTER TABLE `TEAM` DISABLE KEYS */;
INSERT INTO `TEAM` VALUES (1,'항공대');
/*!40000 ALTER TABLE `TEAM` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-12-26 21:56:50
