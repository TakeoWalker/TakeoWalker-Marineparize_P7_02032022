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
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `post_id` int NOT NULL,
  `comment_body` text NOT NULL,
  `comment_likes` int DEFAULT NULL,
  `comment_dislikes` int DEFAULT NULL,
  `create_comment_at` timestamp NOT NULL,
  `modified_comment_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`,`user_id`,`post_id`),
  UNIQUE KEY `comment_id_UNIQUE` (`id`),
  KEY `user_id_comments_idx` (`user_id`),
  KEY `post_id_comments_idx` (`post_id`),
  CONSTRAINT `post_id_comments` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_id_comments` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (2,11,22,'hey je suis un commentaire',NULL,NULL,'2022-03-31 23:08:18',NULL),(4,11,22,'les accents ne marchent pas...',NULL,NULL,'2022-03-31 23:11:36',NULL),(6,11,22,'Normalement tout va bien pour là',NULL,NULL,'2022-04-01 01:14:42',NULL),(7,11,22,'Salut',NULL,NULL,'2022-04-01 02:07:29',NULL),(19,34,22,'Hey =D',NULL,NULL,'2022-04-01 23:29:32',NULL),(20,34,22,' Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut aliquet ac orci at eleifend. Quisque gravida augue non massa laoreet faucibus. Nullam massa nisl, aliquet nec condimentum pulvinar, ullamcorper sit amet nisi. Vivamus lobortis quam in posuere pulvinar. Duis luctus diam quis tellus sollicitudin convallis. In accumsan dolor volutpat bibendum fermentum. Curabitur sit amet fermentum mi.  Proin diam lectus, molestie et venenatis eu, faucibus efficitur ante. Nullam arcu sem, ultricies a sem non, pellentesque elementum quam. Praesent ut dapibus dolor. Quisque orci mi, ultrices a lorem et, venenatis consectetur magna. Nullam tincidunt urna in leo auctor mattis. Praesent vehicula blandit quam non varius. Curabitur vel semper felis, at cursus nulla. Donec commodo porttitor augue non vulputate.  Nulla faucibus dictum molestie. Pellentesque odio nisi, pharetra ut lacus nec, tempus dapibus erat. Morbi luctus bibendum nisi et ultrices. Mauris sit amet lacus sapien. Donec viverra nulla vehicula tortor condimentum, non fermentum ex malesuada. Nulla interdum condimentum laoreet. Morbi non consectetur augue, vitae tempor dolor. Aliquam sit amet eleifend est. Sed non posuere lacus, sagittis cursus dolor. Cras viverra dolor arcu.  Integer rutrum lacus eget dui fermentum, nec molestie tellus tempor. Cras in mi vitae enim ornare scelerisque at ut quam. Aenean sit amet molestie lorem, nec scelerisque risus. Mauris at nunc accumsan, hendrerit erat et, ornare tortor. Pellentesque sed semper libero, ac blandit nulla. Etiam placerat a dolor vitae efficitur. Fusce at commodo lectus. Suspendisse interdum id neque quis convallis. Duis ut dolor et eros pharetra tincidunt suscipit vel sapien. ',NULL,NULL,'2022-04-01 23:34:44',NULL);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
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
