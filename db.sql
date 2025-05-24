-- --------------------------------------------------------
-- Host:                         mysql-taskmanger-d-taskmanager-discord.i.aivencloud.com
-- Server version:               8.0.35 - Source distribution
-- Server OS:                    Linux
-- HeidiSQL Version:             12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for hospital_appointment
DROP DATABASE IF EXISTS `hospital_appointment`;
CREATE DATABASE IF NOT EXISTS `hospital_appointment` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `hospital_appointment`;

-- Dumping structure for table hospital_appointment.appointments
DROP TABLE IF EXISTS `appointments`;
CREATE TABLE IF NOT EXISTS `appointments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `doctor_username` varchar(50) NOT NULL,
  `patient_username` varchar(50) NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` time NOT NULL,
  `status` varchar(20) DEFAULT 'Scheduled',
  `description` text,
  `phone_number` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `doctor_username` (`doctor_username`),
  KEY `patient_username` (`patient_username`),
  CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`doctor_username`) REFERENCES `users` (`username`),
  CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`patient_username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table hospital_appointment.appointments: ~24 rows (approximately)
DELETE FROM `appointments`;
INSERT INTO `appointments` (`id`, `doctor_username`, `patient_username`, `appointment_date`, `appointment_time`, `status`, `description`, `phone_number`) VALUES
	(1, 'sara', 'sajid', '2025-04-27', '10:00:00', 'accepted', NULL, NULL),
	(2, 'sara', 'noob', '2025-04-30', '10:30:00', 'pending', 'emergency', NULL),
	(3, 'sara', 'noob', '2025-04-30', '16:00:00', 'completed', 'ge', NULL),
	(4, 'sara', 'noob', '2025-04-26', '16:30:00', 'completed', 'hello', NULL),
	(5, 'sara', 'noob', '2025-04-30', '10:30:00', 'completed', 'some thing importtant', NULL),
	(6, 'sara', 'sajid', '2025-04-26', '14:00:00', 'Accepted', 'not so important', '+8801231238170'),
	(7, 'sara', 'noob', '2025-04-30', '12:00:00', 'Pending', 'kk', '+8801231238170'),
	(8, 'newdoc', 'sajid', '2025-04-30', '14:00:00', 'pending', 'hehehehehe', '+8801231238170'),
	(10, 'newdoc', 'sajid', '2025-04-30', '13:30:00', 'accepted', 'fdfdfdfd', '+8801231238170'),
	(11, 'newdoc', 'sajid', '2025-04-29', '14:00:00', 'completed', 'sdsd', '+8801231238170'),
	(12, 'newdoc', 'sajid', '2025-04-30', '14:30:00', 'pending', 'sdas', '+8801231238170'),
	(13, 'newdoc', 'sajid', '2025-05-15', '12:00:00', 'canceled', 'adasdwffd', '+8801231238170'),
	(14, 'newdoc', 'sajid', '2025-04-30', '15:00:00', 'Cancelled', 'khob e emergency vai moira jaimo. ', '+8801605135004'),
	(15, 'newdoc', 'sajid', '2025-04-30', '17:00:00', 'canceled', 'test2', '+8801231238170'),
	(16, 'sara', 'sajid', '2025-05-01', '10:30:00', 'canceled', 'EMERGENCY NEEDED', '+8801231238170'),
	(17, 'newdoc', 'test', '2025-05-03', '10:00:00', 'completed', 'kisu ekta', '+8801231238170'),
	(18, 'sara', 'mofiz', '2025-05-15', '11:00:00', 'pending', 'hh', '+8801231238170'),
	(19, 'sara', 'mofiz', '2025-05-15', '11:30:00', 'pending', 'dagger', '+8801231238170'),
	(20, 'newdoc', 'sajid', '2025-05-17', '14:00:00', 'Pending', 'sda', '+8801231238170'),
	(21, 'newdoc', 'sourav', '2025-05-19', '13:00:00', 'accepted', 'adsada', '+8801231238170'),
	(22, 'hafiz', 'Hafizur Rahman', '2025-05-20', '12:00:00', 'pending', 'I want to book this time. ', '+8801777236613'),
	(23, 'Dr. Farhana Islam', 'Abul Bashar', '2025-05-21', '16:00:00', 'Accepted', 'I want to book this slot.', '+8801777236613'),
	(24, 'newdoc', 'sajid', '2025-05-21', '10:30:00', 'pending', 'amar supositor lagbe onek jor ', '+8801743535798'),
	(25, 'newdoc', 'sajid', '2025-05-21', '10:00:00', 'accepted', 'rwedrw', '+8801743535798');

-- Dumping structure for table hospital_appointment.doctor_profiles
DROP TABLE IF EXISTS `doctor_profiles`;
CREATE TABLE IF NOT EXISTS `doctor_profiles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `start_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `end_time` varchar(50) DEFAULT NULL,
  `education` text,
  `expertise` text,
  `telegram` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  CONSTRAINT `doctor_profiles_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table hospital_appointment.doctor_profiles: ~5 rows (approximately)
DELETE FROM `doctor_profiles`;
INSERT INTO `doctor_profiles` (`id`, `username`, `name`, `contact_number`, `email`, `start_time`, `end_time`, `education`, `expertise`, `telegram`) VALUES
	(1, 'sara', 'Ahnaf Hasan', '+8801312727903', 'ahnafhasan9111234@gmail.com', '10:00', '20:00', 'CTG Medical College', 'Nephrology', '1726514215'),
	(2, 'newdoc', 'Sadman Hossain Sajid', '+8801834896054', 'sadmanhossain1282@gmail.com', '08:00', '14:00', 'Southeast Medical college', 'CSE expert', '870001121'),
	(3, 'hafiz', 'Hafiz Rahman', '+8801605135004', 'hafizrahman@gmail.com', '12:00', '17:00', 'Dhaka Medical College', 'Nephrology', NULL),
	(4, 'Hafizur Rahman', 'Hafizur Rahman', '+8801605135004', 'hafizrahman@gmail.com', '12:00', '19:00', 'Dhaka Medical College', 'Nephrology', NULL),
	(5, 'Dr. Farhana Islam', 'Farhana Islam', '', 'farhanaislamdr@gmail.com', '13:30', '21:00', 'Dhaka Medical College', 'NFC', NULL);

-- Dumping structure for table hospital_appointment.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','doctor','patient') NOT NULL,
  `name` varchar(100) NOT NULL,
  `contact` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table hospital_appointment.users: ~17 rows (approximately)
DELETE FROM `users`;
INSERT INTO `users` (`id`, `username`, `password`, `role`, `name`, `contact`) VALUES
	(1, 'admin', 'admin', 'admin', 'Sadman Hossain Sajid', '1234'),
	(3, 'sajid', '1234', 'patient', 'Sadman Dude', '+88023791283'),
	(4, 'sara', '1122', 'doctor', 'Ahnaf Hasan', NULL),
	(5, 'noob', '1122', 'patient', 'Shishir Khan', NULL),
	(6, 'newdoc', '1122', 'doctor', 'Sadman Hossain Sajid', '1234566778'),
	(7, 'test', '1122', 'patient', 'Shishir Khan', '+8801834896054'),
	(8, 'mofiz', 'mofiz', 'patient', 'Mofiz Uddin', '+8801923100625'),
	(9, 'test1', '1234', 'patient', 'test1', NULL),
	(10, 'test2', '1234', 'patient', 'test1', NULL),
	(11, 'test3', '1122', 'patient', 'test1', NULL),
	(13, 'sourav', '1122', 'patient', 'Mohammad Shourav', '+8801834896054'),
	(14, 'hafiz', '1122', 'doctor', 'Hafiz Rahman', NULL),
	(15, 'Hafizur Rahman', '11220', 'patient', 'Hafizur Rahman', '01777236613'),
	(17, 'nafis', '12345', 'doctor', 'Dr. Nafis Ahmed', NULL),
	(18, 'farhana', '12345', 'doctor', 'Dr. Farhana Islam', NULL),
	(19, 'Dr. Farhana Islam', '12345', 'doctor', 'Farhana Islam', NULL),
	(20, 'Abul Bashar', '12345', 'patient', 'Abul Bashar', '01689983479');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
