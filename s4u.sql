-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 08, 2022 at 12:28 AM
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
-- Database: `s4u`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `booking_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `provider_service_id` int(11) NOT NULL,
  `comment` text DEFAULT NULL,
  `app_date` date DEFAULT NULL,
  `app_time` time DEFAULT NULL,
  `datetime` date NOT NULL,
  `status` enum('P','A','D','R') NOT NULL DEFAULT 'P',
  `book_address` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`booking_id`, `customer_id`, `provider_service_id`, `comment`, `app_date`, `app_time`, `datetime`, `status`, `book_address`) VALUES
(1, 1, 1, 'I have an alery with milk products', '2022-08-03', '17:52:14', '2022-07-20', 'P', '160 uniersity Ave West');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `image` varchar(200) NOT NULL DEFAULT '',
  `banner` varchar(200) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `title`, `description`, `image`, `banner`) VALUES
(1, 'Makeup Artist', 'test', 'test.jpg', 'test.png'),
(2, 'Hair Salon', 'hair', 'qwerty.jpg', 'qwerty.jpg'),
(3, 'Handyman', 'A handyman, also known as a fixer, handyperson or handyworker, is a person skilled at a wide range of repairs, typically around the home. These tasks include trade skills, repair work, maintenance work, are both interior and exterior, and are sometimes described as \"side work\", \"odd jobs\" or \"fix-up tasks\".', 'test.jpg', 'test.jpg'),
(4, 'Appliance Repair', 'Appliance repair technicians repair damaged or malfunctioning home appliances as well as install and maintain functioning appliances. They work on-site and in repair shops, depending on the size of the appliance and the type of work required.', 'test.jpg', 'test.jpg'),
(5, 'Electrician', 'Electricians install, alter, repair and maintain electrical systems designed to provide heat, light, power, control, signal or fire alarms for all types of buildings, structures and premises.', 'test.jpg', 'test.jpg'),
(6, 'Home Cleaning', 'Housecleaning may be sweeping the floor with a broom, cleaning rugs with a vacuum cleaner, cleaning clothes and putting them away, and washing windows.', 'test.jpg', 'test.jpg'),
(7, 'Computer Technician', 'A computer repair technician is a person who repairs and maintains computers and servers. The technician\'s responsibilities may extend to include building or configuring new hardware, installing and updating software packages, and creating and maintaining computer networks.', 'test.jpg', 'test.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `phone` int(12) NOT NULL,
  `email` varchar(20) NOT NULL,
  `password` varchar(225) NOT NULL,
  `address` text DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `pincode` varchar(10) DEFAULT NULL,
  `is_active` int(1) NOT NULL DEFAULT 1,
  `is_deleted` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `first_name`, `last_name`, `phone`, `email`, `password`, `address`, `location`, `pincode`, `is_active`, `is_deleted`) VALUES
(1, 'Admin', 'Developer', 1253658745, 'admin@test.com', '123456', NULL, NULL, NULL, 1, 0),
(2, 'Deepak', 'Joshi', 2147483647, 'qwerty@test.com', '12345678', '137 university ave', NULL, 'N2l3e6', 1, 0),
(3, 'Jhon', 'Doe', 2147483647, 'admin@admin.com', '123123', '137 university ave', NULL, 'N2k5lu', 1, 0),
(4, 'sadasd', 'asdas', 1536874568, 'tester@admin.com', '123123', '', NULL, '', 1, 0),
(5, 'Abinash', 'Rai', 2147483647, 'abhi@s4u.com', '123456789', NULL, NULL, NULL, 1, 0),
(6, 'check new', 'user', 256587459, 'checkuser@test.com', '123123123', NULL, NULL, NULL, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `providers`
--

CREATE TABLE `providers` (
  `provider_id` int(11) NOT NULL,
  `company_name` varchar(50) NOT NULL DEFAULT '',
  `contact_no` bigint(12) NOT NULL,
  `email` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(50) NOT NULL DEFAULT '',
  `address` text DEFAULT NULL,
  `pincode` varchar(50) DEFAULT NULL,
  `access_km` int(11) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `front_image` varchar(225) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `providers`
--

INSERT INTO `providers` (`provider_id`, `company_name`, `contact_no`, `email`, `password`, `address`, `pincode`, `access_km`, `category_id`, `front_image`) VALUES
(1, 'Chatters Hair Salon', 5197473178, 'salon@chattershairsalon.ca', 'admin@123', '550 King St N N21, Waterloo, ON ', 'N2L 5W6', 10, 2, 'nurisalon.jpeg'),
(2, 'Andrew Nuri Hair Studio', 5197457772, 'info@andrewnuri.ca', 'admin@123', '203 Lester St, Waterloo, ON', 'N2L 3W3', 8, 2, 'belmontsalon.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `provider_service`
--

CREATE TABLE `provider_service` (
  `provider_service_id` int(10) NOT NULL,
  `provider_id` int(1) NOT NULL,
  `service_id` int(1) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `provider_service`
--

INSERT INTO `provider_service` (`provider_service_id`, `provider_id`, `service_id`, `price`) VALUES
(1, 1, 1, 30),
(2, 2, 1, 35),
(3, 1, 9, 45),
(4, 1, 13, 50);

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE `service` (
  `service_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `description` varchar(11) NOT NULL,
  `image` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`service_id`, `category_id`, `name`, `description`, `image`) VALUES
(1, 1, 'Full Body Waxing', '', '0'),
(3, 1, 'Wedding Makeup', '', '0'),
(5, 1, 'Bridal Makeup', '', 'test.jpg'),
(6, 1, 'Facial Massage', '', 'test.jpg'),
(7, 1, 'Manicure & Pedicure', '', 'test.jpg'),
(8, 2, 'Hair Cutting', '', 'test.jpg'),
(9, 2, 'Beard Trim', '', 'test.jpg'),
(10, 2, 'Color', '', 'test.jpg'),
(11, 2, 'Perms', '', 'test.jpg'),
(12, 2, 'Blow Dry', '', 'test.jpg'),
(13, 2, 'Hair Cut with Blow Dry', '', 'test.jpg'),
(14, 3, 'Dry Wall Repair', '', 'test.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`booking_id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`) USING BTREE;

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`);

--
-- Indexes for table `providers`
--
ALTER TABLE `providers`
  ADD PRIMARY KEY (`provider_id`);

--
-- Indexes for table `provider_service`
--
ALTER TABLE `provider_service`
  ADD PRIMARY KEY (`provider_service_id`);

--
-- Indexes for table `service`
--
ALTER TABLE `service`
  ADD PRIMARY KEY (`service_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `providers`
--
ALTER TABLE `providers`
  MODIFY `provider_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10003;

--
-- AUTO_INCREMENT for table `provider_service`
--
ALTER TABLE `provider_service`
  MODIFY `provider_service_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `service`
--
ALTER TABLE `service`
  MODIFY `service_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
