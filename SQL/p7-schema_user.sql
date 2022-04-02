-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: p7-schema
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(355) NOT NULL,
  `email` varchar(355) NOT NULL,
  `created_on` timestamp NOT NULL,
  `role` varchar(45) DEFAULT 'employee',
  `icon_url` varchar(600) DEFAULT '../assets/defaultIcon.png',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `user_id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (7,'Takeo Walker','$2b$10$UtdZgZWjqRFF0J8V57L3X.10WNczQYX4A/nuhd432YLLaG4YAw.C2','marineparize2@test.fr','2022-03-06 23:00:00','employee','http://localhost:3000/images/badge_IB_mary.png1648903827276.png'),(9,'Takeowalker','$2b$10$3NCoEwFLLoZl/e4qKF9GoeINObuuzcQpIW6aYRRNJPfEB1YjGZ.BG','takeowalker@test.fr','2022-03-26 23:00:00','employee','../assets/defaultIcon.png'),(10,'Marine','$2b$10$eKXRUEJ9u4pstT6gdZtUI.vocw//K9xCa3yF3jluiiS8xG1zfnVxS','mp@test.fr','2022-03-26 23:00:00','employee','../assets/defaultIcon.png'),(11,'maddie','$2b$10$XBuPeUF8SMzWLHuOvdxuZuDnKSdw6t4wfU4Wy4zYBRa4X5Odr8j66','maddie@test.fr','2022-03-27 21:17:04','employee','../assets/defaultIcon.png'),(13,'Francis','$2b$10$WxJ2HUCnkXCSvYN1Fa8Aq.rcpbpiuiwa//oNo.yg9PwPSIsvyg5hC','francis@test.fr','2022-03-29 09:49:22','employee','../assets/defaultIcon.png'),(16,'Francis2','$2b$10$BEm7y02jZ6F.qFRyy4Stg.mgJVc6SdSRJGxWdVwkDFB2CAyjx.Ikq','francis2@test.fr','2022-03-29 09:51:43','employee','../assets/defaultIcon.png'),(18,'Francis3','$2b$10$ac8UKvmSCxh0dGQaEW7cYe7tpWAebKiPtgmp5hPUlUP8OCa30834K','francis3@test.fr','2022-03-29 09:55:17','employee','../assets/defaultIcon.png'),(19,'ludwig2','$2b$10$ZbRCKouPZ/b/6ZuiGXIveO2IB0WPWsBiU8j3fvETOPWFaushy.vkW','ludwig2@test.fr','2022-03-29 10:03:05','employee','../assets/defaultIcon.png'),(20,'ludwig3','$2b$10$nSG/inc1/QdaWNPnieat8Ozia09IVpMloJXlII7l5qVzJDq2/vH2y','ludwig3@test.fr','2022-03-29 10:04:50','employee','../assets/defaultIcon.png'),(21,'tiramisu','$2b$10$Jn7Q101qnT.ZNkXwHwPOWeSjxrrevmB7agoU/cIvIta.1qvTEbiXO','tiramisu@test.fr','2022-03-29 10:10:33','employee','../assets/defaultIcon.png'),(22,'misu','$2b$10$tr9L/YNakiIQo2cB4wAuee7KaUrc6ietAdOx4jTvKvH6q.9BOi1sK','misu@test.fr','2022-03-29 10:31:22','employee','../assets/defaultIcon.png'),(23,'misu2','$2b$10$zBG4wQnLqqw/rAJ5/SOHFOzzERj18GhQzUdNHWlvsJlfsvUDON5W.','misu2@test.fr','2022-03-29 10:36:01','employee','../assets/defaultIcon.png'),(26,'misu3','$2b$10$xrmtRaphYqdglHCm/AnSpu3UMZYe0KIFoq7E/l7yPbNEhFlm5trOi','misu3@test.fr','2022-03-29 10:37:39','employee','../assets/defaultIcon.png'),(27,'Claff','$2b$10$aKCqsx/P2SgjGhgzr6aazeBDnEbg1vrdhjeeD7N12L2auTlB.aoWK','claff@test.fr','2022-03-29 10:39:42','employee','../assets/defaultIcon.png'),(28,'Claff1','$2b$10$bvy8qrYjjtG8XhgaYrVuxOc3wu5d7vzAWLgnyQ4Bn0zT/JItOlbNO','claff1@test.fr','2022-03-29 10:42:46','employee','../assets/defaultIcon.png'),(29,'Claff2','$2b$10$0USDNgiwJni6XEzTv7Jz1eoJTdNrhQpFQ3vjQn12XF8QCM1pxaSae','claff2@test.fr','2022-03-29 10:46:37','employee','../assets/defaultIcon.png'),(30,'Claff3','$2b$10$/Z9uW1Xn22X3VeGWVzBmQulBIKfgoQrUPKuM3lp4BQ/CkWNvyahia','claff3@test.fr','2022-03-29 10:47:53','employee','../assets/defaultIcon.png'),(31,'Moony','$2b$10$aAI1o5yay1QRrdOq93/FEuPRzUPF0T2XfZX1A.neFL9RiZ6rnxuQS','moony@test.fr','2022-03-29 10:49:43','employee','../assets/defaultIcon.png'),(33,'moony1','$2b$10$WjiSpe3Jkchyz.mm8qHBNOFNmDYHe5OmaOadH2a5LabfLz2V6NMXC','moony1@test.fr','2022-03-29 10:57:21','employee','../assets/defaultIcon.png'),(34,'Emeric Harshley','$2b$10$LEL.kNTgqMG.9AOoVDidoOSXXhMMUjMBzSv6SdEsY7F/kH5eH/.ke','emeric@gmail.com','2022-04-01 04:12:12','admin','http://localhost:3000/images/badge_soulmark_emeric_finish.png1648897694324.png'),(35,'Elorri','$2b$10$d9Fc2RCoKauHnodxeV87x.UwWkvnXJM9Yu6B9GZ2fdXL3ce1uz4nG','elorri@test.fr','2022-04-01 10:02:53','employee','../assets/defaultIcon.png'),(36,'ludwig','$2b$10$YJ7HnsifRWztOMsuv9mdTuKvNxVAgiLbqA9zHNyU.FwkGCPf5fJWK','ludwig@test.fr','2022-04-02 08:29:52','employee','../assets/defaultIcon.png');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-02 14:53:40
