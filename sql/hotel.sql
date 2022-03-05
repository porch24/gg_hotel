-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 23, 2022 at 08:35 AM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 8.0.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hotel`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(11) NOT NULL,
  `booking_no` varchar(20) NOT NULL,
  `book_detail_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `payment_id` int(11) NOT NULL,
  `deposit` int(11) NOT NULL,
  `status` enum('RESERVED','CHECK_IN','CHECK_OUT','CANCEL') NOT NULL,
  `booking_date` date NOT NULL,
  `created_at` datetime NOT NULL,
  `created_user_id` int(11) NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `booking_no`, `book_detail_id`, `user_id`, `room_id`, `payment_id`, `deposit`, `status`, `booking_date`, `created_at`, `created_user_id`, `updated_at`, `updated_user_id`) VALUES
(1, 'B001', 1, 1, 1, 1, 1000, 'RESERVED', '2022-02-23', '2022-02-22 19:48:38', 1, '2022-02-22 19:48:38', 1),
(2, 'B002', 2, 1, 1, 2, 100, 'RESERVED', '2022-02-24', '2022-02-23 02:15:06', 1, '2022-02-23 02:15:06', 1);

-- --------------------------------------------------------

--
-- Table structure for table `booking_details`
--

CREATE TABLE `booking_details` (
  `id` int(11) NOT NULL,
  `date_in` datetime NOT NULL,
  `date_out` datetime NOT NULL,
  `check_in` datetime NOT NULL,
  `check_out` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `created_user_id` int(11) NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_type` enum('DEPOSIT','PAID') NOT NULL,
  `created_at` datetime NOT NULL,
  `created_user_id` int(11) NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL,
  `room_number` varchar(10) NOT NULL,
  `room_price` decimal(10,2) NOT NULL,
  `room_type` enum('STANDARD','SUPEIROR','DELUXE','SUITE') NOT NULL,
  `bed_type` enum('SINGLE_BEDDED','TWIN_BEDDED','DOUBLE_BEDDED','TRIPLE_BEDDED') NOT NULL,
  `created_at` datetime NOT NULL,
  `created_user_id` int(11) NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `room_number`, `room_price`, `room_type`, `bed_type`, `created_at`, `created_user_id`, `updated_at`, `updated_user_id`) VALUES
(1, 'A1', '3500.00', 'STANDARD', 'SINGLE_BEDDED', '2022-02-22 16:22:59', 1, '2022-02-22 16:22:59', 1),
(2, 'A2', '3500.00', 'STANDARD', 'SINGLE_BEDDED', '2022-02-22 16:22:59', 1, '2022-02-22 16:22:59', 1),
(3, 'A3', '3700.00', 'STANDARD', 'TWIN_BEDDED', '2022-02-22 16:44:19', 1, '2022-02-22 16:44:19', 1),
(4, 'A4', '3700.00', 'STANDARD', 'TWIN_BEDDED', '2022-02-22 16:44:19', 1, '2022-02-22 16:44:19', 1),
(5, 'A5', '3700.00', 'STANDARD', 'DOUBLE_BEDDED', '2022-02-22 16:45:13', 1, '2022-02-22 16:45:13', 1),
(6, 'A6', '3700.00', 'STANDARD', 'DOUBLE_BEDDED', '2022-02-22 16:45:13', 1, '2022-02-22 16:45:13', 1),
(7, 'A7', '3800.00', 'STANDARD', 'TRIPLE_BEDDED', '2022-02-22 16:46:15', 1, '2022-02-22 16:46:15', 1),
(8, 'A8', '3800.00', 'STANDARD', 'TRIPLE_BEDDED', '2022-02-22 16:46:15', 1, '2022-02-22 16:46:15', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `user_role_id` int(11) NOT NULL,
  `locale` varchar(100) NOT NULL,
  `enabled` tinyint(4) NOT NULL,
  `created_at` datetime NOT NULL,
  `created_user_id` int(11) NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `first_name`, `last_name`, `user_role_id`, `locale`, `enabled`, `created_at`, `created_user_id`, `updated_at`, `updated_user_id`) VALUES
(1, 'admin', '$2y$10$AG.ltxsSn6jfR1wveS7jreu9eWIz.qou9sBjA3OLa3FWUnKKg/5Ta', 'admin', 'admin', 1, 'admin', 0, '2022-02-22 13:19:53', 1, '2022-02-22 13:19:53', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `booking_details`
--
ALTER TABLE `booking_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `booking_details`
--
ALTER TABLE `booking_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
