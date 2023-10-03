CREATE DATABASE  IF NOT EXISTS `rail_ease` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `rail_ease`;
-- MySQL dump 10.13  Distrib 8.0.31, for macos12 (x86_64)
--
-- Host: 127.0.0.1    Database: rail_ease
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
-- Table structure for table `booked_seats`
--

DROP TABLE IF EXISTS `booked_seats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booked_seats` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Primary key of record.',
  `booking_id` int NOT NULL COMMENT 'Booking id to which the seat belongs to.',
  `seat_number` int NOT NULL COMMENT 'Seat number that is booked for booking.',
  `created_at` timestamp NOT NULL COMMENT 'Date when record is created.',
  `updated_at` timestamp NOT NULL COMMENT 'Date when record is updated.',
  PRIMARY KEY (`id`),
  KEY `fk_booked_seat_x_bookings_idx` (`booking_id`),
  CONSTRAINT `fk_booked_seat_x_bookings` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table to store booked seat details.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booked_seats`
--

LOCK TABLES `booked_seats` WRITE;
/*!40000 ALTER TABLE `booked_seats` DISABLE KEYS */;
/*!40000 ALTER TABLE `booked_seats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `coach_id` int NOT NULL COMMENT 'Train id for which booking is done.',
  `user_id` int NOT NULL COMMENT 'User id for whom booking is done.',
  `departure_station_id` int NOT NULL COMMENT 'Source station id of train.',
  `arrival_station_id` int NOT NULL COMMENT 'Destination station id of train',
  `departure_date_time` datetime NOT NULL COMMENT 'Date time when train leave source station.',
  `arrival_date_time` datetime NOT NULL COMMENT 'Date time when train reach destination.',
  `seat_number` int NOT NULL COMMENT 'Allotted seat number to user.',
  `booking_date` datetime NOT NULL COMMENT 'Date when booking is initiated',
  `status` varchar(45) NOT NULL COMMENT 'Booking status eg. confirmed, cancel, pending, etc',
  `created_at` timestamp NOT NULL COMMENT 'Date time when record is created.',
  `updated_at` timestamp NOT NULL COMMENT 'Date time when record is updated',
  PRIMARY KEY (`id`),
  KEY `fk_user_id_x_users_idx` (`user_id`),
  KEY `fk_departure_station_id_x_stations_idx` (`departure_station_id`),
  KEY `fk_arrival_station_id_x_stations_idx` (`arrival_station_id`),
  KEY `fk_bookings_x_coach_idx` (`coach_id`),
  CONSTRAINT `fk_arrival_station_id_x_stations` FOREIGN KEY (`arrival_station_id`) REFERENCES `stations` (`id`),
  CONSTRAINT `fk_bookings_x_coach` FOREIGN KEY (`coach_id`) REFERENCES `coaches` (`id`),
  CONSTRAINT `fk_departure_station_id_x_stations` FOREIGN KEY (`departure_station_id`) REFERENCES `stations` (`id`),
  CONSTRAINT `fk_user_id_x_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table to store booking details.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coaches`
--

DROP TABLE IF EXISTS `coaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coaches` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Primary key of coach.',
  `train_id` int NOT NULL COMMENT 'Train id to which coach belongs to',
  `coach_number` varchar(45) NOT NULL COMMENT 'Coach number',
  `type` varchar(45) NOT NULL COMMENT 'Type of coach eg. Sleeper, AC First class, AC Second Class, etc',
  `fare` float NOT NULL COMMENT 'Fare of seats in coach.',
  `total_seats` int NOT NULL COMMENT 'Total seats in coach',
  `available_seats` int NOT NULL COMMENT 'Seats available for booking.',
  `created_at` timestamp NOT NULL COMMENT 'Date time when record is created.',
  `updated_at` timestamp NOT NULL COMMENT 'Date time when record is updated.',
  PRIMARY KEY (`id`),
  KEY `fk_coaches_x_train_id_idx` (`train_id`),
  CONSTRAINT `fk_coaches_x_train_id` FOREIGN KEY (`train_id`) REFERENCES `trains` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table to store coach details.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coaches`
--

LOCK TABLES `coaches` WRITE;
/*!40000 ALTER TABLE `coaches` DISABLE KEYS */;
/*!40000 ALTER TABLE `coaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `designation`
--

DROP TABLE IF EXISTS `designation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `designation` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Id of designation.',
  `name` varchar(45) NOT NULL COMMENT 'Name of designation',
  `role_responsibility` text NOT NULL COMMENT 'Role and responsibilities of this designation.',
  `created_at` timestamp NOT NULL COMMENT 'Date when record is created.',
  `updated_at` timestamp NOT NULL COMMENT 'Date when record is updated.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table to store designation detail';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `designation`
--

LOCK TABLES `designation` WRITE;
/*!40000 ALTER TABLE `designation` DISABLE KEYS */;
/*!40000 ALTER TABLE `designation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Primary key for record',
  `boking_id` int NOT NULL COMMENT 'Booking id for which payment is done.',
  `payment_date` datetime NOT NULL COMMENT 'Date when payment is done',
  `payment_amount` float NOT NULL COMMENT 'Amount paid',
  `payment_status` varchar(45) NOT NULL DEFAULT '' COMMENT 'Status of payment eg. Paid, pending',
  `created_at` timestamp NOT NULL COMMENT 'Date time when record is created',
  `updated_at` timestamp NOT NULL COMMENT 'Date time when record is updated.',
  PRIMARY KEY (`id`),
  KEY `fk_booking_id_x_bookings_idx` (`boking_id`),
  CONSTRAINT `fk_booking_id_x_bookings` FOREIGN KEY (`boking_id`) REFERENCES `bookings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table to store payment related details';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `id` int NOT NULL AUTO_INCREMENT,
  `designation_id` int NOT NULL COMMENT 'Designation of staff member.',
  `member_id` varchar(200) NOT NULL COMMENT 'Member id of staff member.',
  `name` varchar(200) NOT NULL COMMENT 'Name of staff member.',
  `email` varchar(200) NOT NULL COMMENT 'Email id of staff.',
  `date_of_birth` date NOT NULL COMMENT 'Birth date of staff member.',
  `average_rating` float NOT NULL COMMENT 'Average rating given to staff member.',
  `created_at` timestamp NOT NULL COMMENT 'Date when record is created.',
  `updated_at` timestamp NOT NULL COMMENT 'Date when record is updated.',
  PRIMARY KEY (`id`),
  KEY `fk_staff_x_designation_idx` (`designation_id`),
  CONSTRAINT `fk_staff_x_designation` FOREIGN KEY (`designation_id`) REFERENCES `designation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table to save detail of staff member.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stations`
--

DROP TABLE IF EXISTS `stations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stations` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Primary key for station',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT 'Name of station',
  `created_at` timestamp NOT NULL COMMENT 'Date when record is created.',
  `updated_at` timestamp NOT NULL COMMENT 'Date when record is updated.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table to store station details';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stations`
--

LOCK TABLES `stations` WRITE;
/*!40000 ALTER TABLE `stations` DISABLE KEYS */;
/*!40000 ALTER TABLE `stations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train_rating`
--

DROP TABLE IF EXISTS `train_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train_rating` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT 'User who give rating.',
  `train_id` int NOT NULL COMMENT 'Train id to give rating.',
  `rating` int NOT NULL COMMENT 'Rating given by user.',
  `review` text NOT NULL COMMENT 'Review given by user.',
  `created_at` timestamp NOT NULL COMMENT 'Date when record is created.',
  `updated_at` timestamp NOT NULL COMMENT 'Date when train rating is given.',
  PRIMARY KEY (`id`),
  KEY `fk_train_rating_x_user_idx` (`user_id`),
  KEY `fk_train_rating_x_train_idx` (`train_id`),
  CONSTRAINT `fk_train_rating_x_train` FOREIGN KEY (`train_id`) REFERENCES `trains` (`id`),
  CONSTRAINT `fk_train_rating_x_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table to store rating details of train.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train_rating`
--

LOCK TABLES `train_rating` WRITE;
/*!40000 ALTER TABLE `train_rating` DISABLE KEYS */;
/*!40000 ALTER TABLE `train_rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train_schedules`
--

DROP TABLE IF EXISTS `train_schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train_schedules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `train_id` int NOT NULL COMMENT 'Train id for schedule.',
  `station_id` int NOT NULL COMMENT 'Station of for train schedule',
  `departure_time` time NOT NULL COMMENT 'Train’s departure time from station.',
  `arrival_time` time NOT NULL COMMENT 'Train’s arrival time at station.',
  `created_at` timestamp NOT NULL COMMENT 'Date when record is created.',
  `updated_at` timestamp NOT NULL COMMENT 'Date when record is updated.',
  PRIMARY KEY (`id`),
  KEY `fk_train_id_x_trains_idx` (`train_id`),
  KEY `fk_station_id_x_station_idx` (`station_id`),
  CONSTRAINT `fk_train_schedule_x_station` FOREIGN KEY (`station_id`) REFERENCES `stations` (`id`),
  CONSTRAINT `fk_train_schedule_x_trains` FOREIGN KEY (`train_id`) REFERENCES `trains` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table to store train schedule details.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train_schedules`
--

LOCK TABLES `train_schedules` WRITE;
/*!40000 ALTER TABLE `train_schedules` DISABLE KEYS */;
/*!40000 ALTER TABLE `train_schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train_staff`
--

DROP TABLE IF EXISTS `train_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train_staff` (
  `id` int NOT NULL AUTO_INCREMENT,
  `train_id` int NOT NULL COMMENT 'Train id on which staff member onboarded.',
  `staff_member_id` int NOT NULL COMMENT 'Staff member id',
  `assigned_date` date NOT NULL COMMENT 'Date when staff member onboarded on train.',
  `released_date` date DEFAULT NULL COMMENT 'Date when staff member released from train service.',
  `remark` text NOT NULL COMMENT 'Remark for staff when onboarded on train.',
  `created_at` timestamp NOT NULL COMMENT 'Date when record is created.',
  `updated_at` timestamp NOT NULL COMMENT 'Date when record is updated.',
  PRIMARY KEY (`id`),
  KEY `fk_train_staff_x_train_idx` (`train_id`),
  KEY `fk_train_staff_x_staff_idx` (`staff_member_id`),
  CONSTRAINT `fk_train_staff_x_staff` FOREIGN KEY (`staff_member_id`) REFERENCES `staff` (`id`),
  CONSTRAINT `fk_train_staff_x_train` FOREIGN KEY (`train_id`) REFERENCES `trains` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table to store train staff.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train_staff`
--

LOCK TABLES `train_staff` WRITE;
/*!40000 ALTER TABLE `train_staff` DISABLE KEYS */;
/*!40000 ALTER TABLE `train_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train_staff_review`
--

DROP TABLE IF EXISTS `train_staff_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train_staff_review` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT 'User who is going to rate and review.',
  `staff_member_id` int NOT NULL COMMENT 'Staff member id for rating and review.',
  `rating` int NOT NULL COMMENT 'Rating provided by user for given staff member.',
  `review` text NOT NULL COMMENT 'Review provided by user for staff member.',
  `created_at` timestamp NOT NULL COMMENT 'Date when record is created.',
  `updated_at` timestamp NOT NULL COMMENT 'Date when record is updated.',
  PRIMARY KEY (`id`),
  KEY `fk_train_staff_review_x_user_idx` (`user_id`),
  KEY `fk_train_staff_review_x_staff_member_idx` (`staff_member_id`),
  CONSTRAINT `fk_train_staff_review_x_staff_member` FOREIGN KEY (`staff_member_id`) REFERENCES `staff` (`id`),
  CONSTRAINT `fk_train_staff_review_x_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train_staff_review`
--

LOCK TABLES `train_staff_review` WRITE;
/*!40000 ALTER TABLE `train_staff_review` DISABLE KEYS */;
/*!40000 ALTER TABLE `train_staff_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trains`
--

DROP TABLE IF EXISTS `trains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trains` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Primary key for train.',
  `departure_station_id` int NOT NULL COMMENT 'Source station id.',
  `arrival_station_id` int NOT NULL COMMENT 'Destination station id',
  `name` varchar(500) NOT NULL DEFAULT '' COMMENT 'Name of the train.',
  `train_number` varchar(45) NOT NULL COMMENT 'Unique train number',
  `departure_time` time NOT NULL COMMENT 'Time when train reach departure station',
  `arrival_time` time NOT NULL COMMENT 'Time when train reach arrival station.',
  `total_seats` int NOT NULL,
  `type` varchar(45) NOT NULL COMMENT 'Type of train eg. Express, super fast, etc',
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_departure_station_x_stations_idx` (`departure_station_id`),
  KEY `fk_arrival_station_x_stations_idx` (`arrival_station_id`),
  CONSTRAINT `fk_arrival_station_x_stations` FOREIGN KEY (`arrival_station_id`) REFERENCES `stations` (`id`),
  CONSTRAINT `fk_departure_station_x_stations` FOREIGN KEY (`departure_station_id`) REFERENCES `stations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table to store train details.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trains`
--

LOCK TABLES `trains` WRITE;
/*!40000 ALTER TABLE `trains` DISABLE KEYS */;
/*!40000 ALTER TABLE `trains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Primary key for record.',
  `username` varchar(200) NOT NULL DEFAULT '' COMMENT 'Username of user.',
  `password` varchar(200) NOT NULL DEFAULT '' COMMENT 'Password of user to login.',
  `email` varchar(200) NOT NULL DEFAULT '' COMMENT 'Email id of user.',
  `mobile_number` varchar(45) NOT NULL DEFAULT '' COMMENT 'Mobile number of user.',
  `address` text NOT NULL COMMENT 'Address of user.',
  `created_at` timestamp NOT NULL COMMENT 'Date when record is created.',
  `updated_at` timestamp NOT NULL COMMENT 'Date when record is updated.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table to store user details';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-03 19:05:49
