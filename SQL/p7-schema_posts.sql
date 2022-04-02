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
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `post_title` varchar(50) NOT NULL,
  `post_body` varchar(50) NOT NULL,
  `post_likes` int DEFAULT NULL,
  `post_dislikes` int DEFAULT NULL,
  `create_post_at` timestamp NOT NULL,
  `modified_post_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`,`user_id`),
  UNIQUE KEY `post_id_UNIQUE` (`id`),
  KEY `post_user_id_idx` (`user_id`),
  CONSTRAINT `post_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (5,7,'2 help','HELP2',NULL,NULL,'2022-03-12 14:34:38',NULL),(6,7,'Salut','Salut',NULL,NULL,'2022-03-12 14:53:14',NULL),(7,7,'post update 1','jessaye!',NULL,NULL,'2022-03-12 17:43:41',NULL),(8,7,'Post 8','Ceci est la MAJ du post 8',NULL,NULL,'2022-03-12 17:46:11',NULL),(12,33,'avec image','Ceci est un nouveau post',NULL,NULL,'2022-03-29 11:25:36',NULL),(13,33,'salut','Je suis un post modifié 2x',NULL,NULL,'2022-03-29 11:37:25','2022-04-02 00:12:31'),(14,33,'qeghrqzjsrkrykry','ldtumlimdyimiùyiùfù*o*',NULL,NULL,'2022-03-29 11:38:09',NULL),(22,11,'damklvndapov','adbrzrjzrkj',NULL,NULL,'2022-03-31 19:14:42',NULL),(36,34,'qdsns,,;','d;d;hd:',NULL,NULL,'2022-04-02 00:15:39',NULL);
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-02  4:05:52
