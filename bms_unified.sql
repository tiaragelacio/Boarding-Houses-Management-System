-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 01, 2026 at 03:09 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bms_unified`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_users`
--

CREATE TABLE `admin_users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(150) NOT NULL,
  `role` enum('super_admin','admin','staff') DEFAULT 'admin',
  `is_active` tinyint(1) DEFAULT 1,
  `last_login` datetime DEFAULT NULL,
  `notifications_read_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_users`
--

INSERT INTO `admin_users` (`id`, `username`, `email`, `password`, `full_name`, `role`, `is_active`, `last_login`, `created_at`) VALUES
(1, 'admin', 'admin@bms.com', '$2y$10$g7tWwBSCW4MuXCCiP.AcvOgefpNJ8DR9RvRfuirWxl3YpLW7KPNpi', 'System Administrator', 'super_admin', 1, '2026-09-01 21:00:05', '2026-03-01 08:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE `announcements` (
  `id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `body` text NOT NULL,
  `type` enum('general','warning','maintenance','reminder') DEFAULT 'general',
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `starts_at` date DEFAULT NULL,
  `expires_at` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `announcements`
--

INSERT INTO `announcements` (`id`, `title`, `body`, `type`, `created_by`, `created_at`) VALUES
(1, 'Wala Tubig Bwas', 'hahahahahhaha', 'maintenance', 1, '2026-08-12 00:26:02');

-- --------------------------------------------------------

--
-- Table structure for table `app_settings`
--

CREATE TABLE `app_settings` (
  `setting_key` varchar(100) NOT NULL,
  `setting_value` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`setting_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `app_settings`
--

INSERT INTO `app_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES
('rent_reminders_last_run', '2026-09-01', '2026-09-01 20:13:03');

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `tenant_id` int(11) DEFAULT NULL,
  `actor_type` enum('admin','tenant') DEFAULT 'admin',
  `action` varchar(100) NOT NULL,
  `details` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `admin_id`, `tenant_id`, `actor_type`, `action`, `details`, `ip_address`, `created_at`) VALUES
(1, 1, NULL, 'admin', 'ADD_ROOM', 'Added room 101 (bedspace)', '::1', '2026-03-26 15:02:11'),
(2, 1, NULL, 'admin', 'UPDATE_ROOM', 'Updated room 101 (id=1)', '::1', '2026-03-26 23:03:39'),
(3, 1, NULL, 'admin', 'CREATE_ROOM', 'Added room 102', '::1', '2026-03-26 23:04:14'),
(4, 1, NULL, 'admin', 'CREATE_ROOM', 'Added room 103', '::1', '2026-03-26 23:05:19'),
(5, 1, NULL, 'admin', 'CONTACT_INQUIRY', 'Marked inquiry id=4 as contacted', '::1', '2026-03-26 23:07:10'),
(6, 1, NULL, 'admin', 'ACCEPT_INQUIRY', 'Accepted inquiry id=4 — tenant account created/updated for lesterballaran02@gmail.com in room 101', '::1', '2026-03-26 23:08:05'),
(7, 1, NULL, 'admin', 'PAYMENT_ACCEPT', 'Accepted payment ID: 1', '::1', '2026-03-26 23:13:24'),
(8, 1, NULL, 'admin', 'DELETE_MAINTENANCE', 'Deleted request id=1', '::1', '2026-03-26 23:25:32'),
(9, 1, NULL, 'admin', 'UPDATE_MAINTENANCE', 'Updated request id=2: No Electricity', '::1', '2026-03-26 23:26:09'),
(10, 1, NULL, 'admin', 'RESOLVE_MAINTENANCE', 'Resolved request id=2', '::1', '2026-03-26 23:26:16'),
(11, 1, NULL, 'admin', 'UPDATE_MAINTENANCE', 'Updated request id=3: Internet', '::1', '2026-03-26 23:28:15'),
(12, 1, NULL, 'admin', 'UPDATE_MAINTENANCE', 'Updated request id=2: No Electricity', '::1', '2026-03-26 23:28:22'),
(13, 1, NULL, 'admin', 'DELETE_MAINTENANCE', 'Deleted request id=4', '::1', '2026-03-26 23:54:46'),
(14, NULL, NULL, 'tenant', 'LOGOUT', 'Tenant signed out', '::1', '2026-03-27 00:04:30'),
(15, 1, NULL, 'admin', 'PAYMENT_ACCEPT', 'Accepted payment ID: 2', '::1', '2026-03-27 01:05:59'),
(16, 1, NULL, 'admin', 'CREATE_ROOM', 'Added room 12', '::1', '2026-03-27 02:02:52'),
(17, 1, NULL, 'admin', 'UPDATE_ROOM', 'Updated room 101 (id=1)', '::1', '2026-03-27 02:03:18'),
(18, 1, NULL, 'admin', 'CREATE_ROOM', 'Added room room 4 (whole_room)', '::1', '2026-05-13 08:28:31'),
(19, 1, NULL, 'admin', 'DELETE_ROOM', 'Deleted room 102', '::1', '2026-05-14 13:54:18'),
(20, 1, NULL, 'admin', 'DELETE_ROOM', 'Deleted room 103', '::1', '2026-05-14 13:54:21'),
(21, 1, NULL, 'admin', 'DELETE_ROOM', 'Deleted room 12', '::1', '2026-05-14 13:54:24'),
(22, 1, NULL, 'admin', 'DELETE_ROOM', 'Deleted room room 4', '::1', '2026-05-14 13:54:27'),
(23, 1, NULL, 'admin', 'RESOLVE_MAINTENANCE', 'Resolved request id=3', '::1', '2026-05-14 13:54:37'),
(24, 1, NULL, 'admin', 'UPDATE_ROOM', 'Updated room 101 (id=1)', '::1', '2026-05-14 13:55:40'),
(25, 1, NULL, 'admin', 'CONTACT_INQUIRY', 'Marked inquiry id=5 as contacted', '::1', '2026-05-14 13:58:15'),
(26, 1, NULL, 'admin', 'ACCEPT_INQUIRY', 'Accepted inquiry id=5 — tenant account created/updated for lesterballaran02@gmail.com in room 101', '::1', '2026-05-14 14:03:36'),
(27, 1, NULL, 'admin', 'ACCEPT_INQUIRY', 'Accepted inquiry id=5 — tenant account created/updated for lesterballaran02@gmail.com in room 101', '::1', '2026-05-14 14:03:41'),
(28, 1, NULL, 'admin', 'DELETE_TENANT', 'Deleted: Lester', '::1', '2026-05-18 14:15:12'),
(29, 1, NULL, 'admin', 'UPDATE_ROOM', 'Updated room 101 (id=1)', '::1', '2026-05-18 14:15:31'),
(30, 1, NULL, 'admin', 'CONTACT_INQUIRY', 'Marked inquiry id=6 as contacted', '::1', '2026-05-18 14:16:42'),
(31, 1, NULL, 'admin', 'ACCEPT_INQUIRY', 'Accepted inquiry id=6 — lesterballaran02@gmail.com in room 101 (bedspacer)', '::1', '2026-05-18 23:20:01'),
(32, 1, NULL, 'admin', 'CONTACT_INQUIRY', 'Marked inquiry id=7 as contacted', '::1', '2026-05-18 23:20:55'),
(33, 1, NULL, 'admin', 'ACCEPT_INQUIRY', 'Accepted inquiry id=7 — lesterballaran02@gmail.com in room 101 (bedspacer)', '::1', '2026-05-18 23:21:22'),
(34, 1, NULL, 'admin', 'ADD_BRANCH', 'Added branch \"Molo Branch\" (code: bh_003)', '::1', '2026-08-05 03:17:15'),
(35, 1, NULL, 'admin', 'EDIT_BRANCH', 'Updated branch ID 1 (name: SAN ISIDRO BRANCH, status: active)', '::1', '2026-08-05 03:17:33'),
(36, 1, NULL, 'admin', 'EDIT_BRANCH', 'Updated branch ID 2 (name: Dungon Branch, status: active)', '::1', '2026-08-05 03:20:19'),
(37, 1, NULL, 'admin', 'UPDATE_ROOM', 'Updated room 101 (id=1)', '::1', '2026-08-08 03:00:25'),
(38, 1, NULL, 'admin', 'DELETE_TENANT', 'Deleted: Lester Ballaran', '::1', '2026-08-08 03:00:58'),
(39, 1, NULL, 'admin', 'UPDATE_ROOM', 'Updated room 101 (id=1)', '::1', '2026-08-08 03:01:13'),
(40, 1, NULL, 'admin', 'CREATE_ROOM', 'Added room Room 202 (both)', '::1', '2026-08-11 15:56:48'),
(41, 1, NULL, 'admin', 'CONTACT_INQUIRY', 'Marked inquiry id=8 as contacted', '::1', '2026-08-11 15:59:15'),
(42, 1, NULL, 'admin', 'ACCEPT_INQUIRY', 'Accepted inquiry id=8 — lesterballaran02@gmail.com in room Room 202 (bedspacer)', '::1', '2026-08-11 16:00:16'),
(43, 1, NULL, 'admin', 'PAYMENT_ACCEPT', 'Accepted payment ID: 3', '::1', '2026-08-11 16:09:37'),
(44, NULL, NULL, 'tenant', 'LOGOUT', 'Tenant signed out', '::1', '2026-08-11 16:10:21'),
(45, 1, NULL, 'admin', 'CREATE_ROOM', 'Added room Room 303 (both)', '::1', '2026-08-11 16:12:07'),
(46, 1, NULL, 'admin', 'CONTACT_INQUIRY', 'Marked inquiry id=9 as contacted', '::1', '2026-08-11 16:16:29'),
(47, 1, NULL, 'admin', 'ACCEPT_INQUIRY', 'Accepted inquiry id=9 — lebu.ballaran.ui@phinmaed.com in room Room 303 (whole_room)', '::1', '2026-08-11 16:17:32'),
(48, 1, NULL, 'admin', 'PAYMENT_ACCEPT', 'Accepted payment ID: 4', '::1', '2026-08-11 16:19:33'),
(49, 1, NULL, 'admin', 'CREATE_ANNOUNCEMENT', 'Posted: Wala Tubig Bwas', '::1', '2026-08-11 16:26:02'),
(50, 1, NULL, 'admin', 'UPDATE_MAINTENANCE', 'Updated request id=5: No Electricity', '::1', '2026-08-11 16:27:01'),
(51, 1, NULL, 'admin', 'DELETE_TENANT', 'Deleted: Client', '::1', '2026-09-01 12:14:45'),
(52, 1, NULL, 'admin', 'DELETE_TENANT', 'Deleted: Lester', '::1', '2026-09-01 12:14:47'),
(53, 1, NULL, 'admin', 'DELETE_ROOM', 'Deleted room Room 202', '::1', '2026-09-01 12:14:53'),
(54, 1, NULL, 'admin', 'DELETE_ROOM', 'Deleted room 101', '::1', '2026-09-01 12:15:05'),
(55, 1, NULL, 'admin', 'CREATE_ROOM', 'Added room 1 (both)', '::1', '2026-09-01 12:19:03'),
(56, 1, NULL, 'admin', 'DELETE_ROOM', 'Deleted room Room 303', '::1', '2026-09-01 12:21:11'),
(57, 1, NULL, 'admin', 'DELETE_INQUIRY', 'Deleted inquiry id=9', '::1', '2026-09-01 12:24:10'),
(58, 1, NULL, 'admin', 'DELETE_INQUIRY', 'Deleted inquiry id=8', '::1', '2026-09-01 12:24:14'),
(59, 1, NULL, 'admin', 'DELETE_INQUIRY', 'Deleted inquiry id=7', '::1', '2026-09-01 12:24:17'),
(60, 1, NULL, 'admin', 'DELETE_INQUIRY', 'Deleted inquiry id=6', '::1', '2026-09-01 12:24:20'),
(61, 1, NULL, 'admin', 'DELETE_INQUIRY', 'Deleted inquiry id=5', '::1', '2026-09-01 12:24:23'),
(62, 1, NULL, 'admin', 'DELETE_INQUIRY', 'Deleted inquiry id=4', '::1', '2026-09-01 12:24:25'),
(63, 1, NULL, 'admin', 'DELETE_INQUIRY', 'Deleted inquiry id=3', '::1', '2026-09-01 12:24:28'),
(64, 1, NULL, 'admin', 'DELETE_INQUIRY', 'Deleted inquiry id=1', '::1', '2026-09-01 12:24:30'),
(65, 1, NULL, 'admin', 'DELETE_INQUIRY', 'Deleted inquiry id=2', '::1', '2026-09-01 12:24:32'),
(66, 1, NULL, 'admin', 'CONTACT_INQUIRY', 'Marked inquiry id=10 as contacted', '::1', '2026-09-01 12:24:34'),
(67, 1, NULL, 'admin', 'ACCEPT_INQUIRY', 'Accepted inquiry id=10 — hartwaller123@gmail.com in room 1 (whole_room)', '::1', '2026-09-01 12:25:09'),
(68, 1, NULL, 'admin', 'CREATE_ROOM', 'Added room 1 (both)', '::1', '2026-09-01 12:29:15'),
(69, NULL, 5, 'tenant', 'LOGOUT', 'Tenant signed out', '::1', '2026-09-01 12:29:20'),
(70, 1, NULL, 'admin', 'CONTACT_INQUIRY', 'Marked inquiry id=11 as contacted', '::1', '2026-09-01 12:34:00'),
(71, 1, NULL, 'admin', 'ACCEPT_INQUIRY', 'Accepted inquiry id=11 — ashleyacero1826@gmail.com in room 1 (whole_room)', '::1', '2026-09-01 12:35:10'),
(72, 1, NULL, 'admin', 'CREATE_ROOM', 'Added room 1 (both)', '::1', '2026-09-01 12:38:57'),
(73, 1, NULL, 'admin', 'CONTACT_INQUIRY', 'Marked inquiry id=12 as contacted', '::1', '2026-09-01 12:40:28'),
(74, 1, NULL, 'admin', 'ACCEPT_INQUIRY', 'Accepted inquiry id=12 — asge.acero.ui@phinmaed.com in room 1 (whole_room)', '::1', '2026-09-01 12:42:52');

-- --------------------------------------------------------

--
-- Table structure for table `borrowed_items`
--

CREATE TABLE `borrowed_items` (
  `id` int(11) NOT NULL,
  `tenant_id` int(11) NOT NULL,
  `item_name` varchar(150) NOT NULL,
  `quantity` int(11) DEFAULT 1,
  `borrow_date` date NOT NULL,
  `return_date` date DEFAULT NULL,
  `status` enum('borrowed','returned','damaged') DEFAULT 'borrowed',
  `notes` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL COMMENT 'Matches rooms.branch / inquiries.branch values, e.g. branch_1',
  `name` varchar(150) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `code`, `name`, `address`, `status`, `created_at`, `updated_at`) VALUES
(1, 'branch_1', 'SAN ISIDRO BRANCH', NULL, 'active', '2026-08-05 03:16:00', '2026-08-05 03:17:33'),
(2, 'branch_2', 'Dungon Branch', 'Dungon A, Jaro', 'active', '2026-08-05 03:16:00', '2026-08-05 03:20:19'),
(3, 'bh_003', 'Molo Branch', 'MOLO BOULEVARD', 'active', '2026-08-05 03:17:15', '2026-08-05 03:17:15');

-- --------------------------------------------------------

--
-- Table structure for table `contracts`
--

CREATE TABLE `contracts` (
  `id` int(11) NOT NULL,
  `tenant_id` int(11) DEFAULT NULL,
  `room_id` int(11) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `monthly_rate` decimal(10,2) DEFAULT 0.00,
  `deposit` decimal(10,2) DEFAULT 0.00,
  `status` enum('active','expired','terminated') DEFAULT 'active',
  `terms` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inquiries`
--

CREATE TABLE `inquiries` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `contact` varchar(20) DEFAULT NULL,
  `room_type` varchar(50) DEFAULT NULL,
  `branch` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `status` enum('new','contacted','converted','closed') DEFAULT 'new',
  `notes` text DEFAULT NULL,
  `fb_link` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inquiries`
--

INSERT INTO `inquiries` (`id`, `name`, `email`, `contact`, `room_type`, `branch`, `message`, `status`, `notes`, `fb_link`, `created_at`) VALUES
(10, 'Ashley Acero', 'hartwaller123@gmail.com', '09496872536', 'whole_room', 'branch_2', 'nice room with goodlooking', 'converted', 'Interested in Room: 1 | Rental mode: Whole Room | Preferred move-in: 2026-12-02', NULL, '2026-09-01 12:23:31'),
(11, 'Ashe', 'ashleyacero1826@gmail.com', '09111223123123', NULL, 'branch_1', '', 'converted', 'Interested in Room: 1 | Preferred move-in: 2026-12-01', NULL, '2026-09-01 12:33:33'),
(12, 'Ash', 'asge.acero.ui@phinmaed.com', '09213123123123', NULL, 'bh_003', '', 'converted', 'Interested in Room: 1 | Preferred move-in: 2026-12-01', NULL, '2026-09-01 12:40:12');

-- --------------------------------------------------------

--
-- Table structure for table `item_damages`
--

CREATE TABLE `item_damages` (
  `id` int(11) NOT NULL,
  `tenant_id` int(11) NOT NULL,
  `item_name` varchar(150) NOT NULL,
  `description` text NOT NULL,
  `status` enum('reported','acknowledged','resolved') DEFAULT 'reported',
  `reported_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `maintenance_requests`
--

CREATE TABLE `maintenance_requests` (
  `id` int(11) NOT NULL,
  `tenant_id` int(11) DEFAULT NULL,
  `room_id` int(11) DEFAULT NULL,
  `category` varchar(50) DEFAULT 'other',
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `urgency` enum('low','normal','urgent') DEFAULT 'normal',
  `priority` enum('low','medium','high','urgent') DEFAULT 'medium',
  `status` enum('pending','open','in_progress','resolved','cancelled','closed') DEFAULT 'pending',
  `admin_reply` text DEFAULT NULL,
  `resolved_at` datetime DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `submitted_by` enum('admin','tenant') DEFAULT 'tenant',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `maintenance_requests`
--

INSERT INTO `maintenance_requests` (`id`, `tenant_id`, `room_id`, `category`, `title`, `description`, `urgency`, `priority`, `status`, `admin_reply`, `resolved_at`, `notes`, `submitted_by`, `created_at`, `updated_at`) VALUES
(2, NULL, NULL, 'electricity', 'No Electricity', 'Kagapon pani way kuryente ya', 'urgent', 'medium', 'resolved', NULL, '2026-03-27 07:26:16', NULL, 'tenant', '2026-03-27 07:21:47', '2026-03-26 23:28:22'),
(3, NULL, NULL, 'internet', 'Internet', 'nd ko ka ml', 'urgent', 'medium', 'resolved', NULL, '2026-05-14 21:54:37', NULL, 'tenant', '2026-03-27 07:27:57', '2026-05-14 13:54:37'),
(5, NULL, NULL, 'electricity', 'No Electricity', 'wala kuryenteeeeeeeeeeeeeeeeeeeeeeeee', 'urgent', 'medium', 'resolved', NULL, NULL, NULL, 'tenant', '2026-08-12 00:24:30', '2026-08-11 16:27:01');

-- --------------------------------------------------------

--
-- Table structure for table `maintenance_schedules`
--

CREATE TABLE `maintenance_schedules` (
  `id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `type` enum('water_interruption','power_outage','general_repair','pest_control','elevator','cleaning','inspection','other') DEFAULT 'other',
  `scheduled_date` date NOT NULL,
  `scheduled_time` time DEFAULT NULL,
  `estimated_duration` varchar(50) DEFAULT NULL,
  `affected_area` varchar(150) DEFAULT NULL,
  `status` enum('scheduled','ongoing','completed','cancelled') DEFAULT 'scheduled',
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `tenant_id` int(11) DEFAULT NULL,
  `room_id` int(11) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `type` varchar(50) DEFAULT 'rent',
  `due_date` date DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `paid_at` datetime DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `reference` varchar(100) DEFAULT NULL,
  `admin_notes` text DEFAULT NULL,
  `reminder_sent_at` datetime DEFAULT NULL,
  `status` enum('pending','paid','overdue','partial','waived') DEFAULT 'pending',
  `submitted_by` enum('admin','tenant') DEFAULT 'admin',
  `proof_image` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `tenant_id`, `room_id`, `amount`, `type`, `due_date`, `payment_date`, `paid_at`, `payment_method`, `reference`, `admin_notes`, `reminder_sent_at`, `status`, `submitted_by`, `proof_image`, `created_at`) VALUES
(1, NULL, NULL, 2000.00, 'rent', '2026-03-03', '2026-03-27', '2026-03-27 07:13:24', 'GCash', NULL, 'Confirmed.', NULL, 'paid', 'tenant', 'proof_1774566777_1.png', '2026-03-27 07:12:57'),
(2, NULL, NULL, 2000.00, 'rent', '2026-04-03', '2026-03-27', '2026-03-27 09:05:59', 'GCash', NULL, '', NULL, 'paid', 'tenant', 'proof_1774573526_1.png', '2026-03-27 09:05:26'),
(3, NULL, NULL, 1500.00, 'rent', '2026-08-05', '2026-08-12', '2026-08-12 00:09:37', 'GCash', NULL, 'Confirmed', NULL, 'paid', 'tenant', 'proof_1786464098_3.png', '2026-08-12 00:01:38'),
(4, NULL, NULL, 6000.00, 'rent', '2026-08-05', '2026-08-12', '2026-08-12 00:19:33', 'GCash', NULL, 'Confirmed', NULL, 'paid', 'tenant', 'proof_1786465146_4.png', '2026-08-12 00:19:06');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL,
  `room_number` varchar(20) NOT NULL,
  `room_type` enum('whole_room','bedspace') NOT NULL DEFAULT 'whole_room',
  `floor` tinyint(2) NOT NULL DEFAULT 1,
  `capacity` tinyint(2) NOT NULL DEFAULT 1,
  `monthly_rate` decimal(10,2) NOT NULL DEFAULT 0.00,
  `bedspacer_rate` decimal(10,2) NOT NULL DEFAULT 0.00,
  `occupied_beds` tinyint(2) NOT NULL DEFAULT 0,
  `status` enum('vacant','occupied','maintenance','reserved') NOT NULL DEFAULT 'vacant',
  `amenities` varchar(500) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `room_photos` text DEFAULT NULL COMMENT 'JSON array of room interior photo paths',
  `amenity_photos` text DEFAULT NULL COMMENT 'JSON array of amenity feature photo paths',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `branch` varchar(50) NOT NULL DEFAULT 'branch_1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `room_number`, `room_type`, `floor`, `capacity`, `monthly_rate`, `bedspacer_rate`, `occupied_beds`, `status`, `amenities`, `description`, `room_photos`, `amenity_photos`, `created_at`, `updated_at`, `branch`) VALUES
(8, '1', 'whole_room', 1, 7, 7000.00, 1500.00, 0, 'occupied', 'wifi', 'no pet allowed', NULL, NULL, '2026-09-01 12:19:03', '2026-09-01 12:25:09', 'branch_2'),
(9, '1', 'whole_room', 1, 1, 7000.00, 1500.00, 0, 'occupied', 'wifi', 'no wifi', NULL, NULL, '2026-09-01 12:29:15', '2026-09-01 12:35:10', 'branch_1'),
(10, '1', 'whole_room', 1, 7, 7000.00, 1500.00, 0, 'occupied', 'wifi', 'no pet', NULL, NULL, '2026-09-01 12:38:57', '2026-09-01 12:42:52', 'bh_003');

-- --------------------------------------------------------

--
-- Table structure for table `room_images`
--

CREATE TABLE `room_images` (
  `id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `room_images`
--

INSERT INTO `room_images` (`id`, `room_id`, `image_path`, `sort_order`, `created_at`) VALUES
(6, 8, 'room_8_ca152d2aa8e8.png', 0, '2026-09-01 20:19:03'),
(7, 9, 'room_9_76353871ff05.png', 0, '2026-09-01 20:29:15'),
(8, 10, 'room_10_fd097dfda1c1.png', 0, '2026-09-01 20:38:57');

-- --------------------------------------------------------

--
-- Table structure for table `tenants`
--

CREATE TABLE `tenants` (
  `id` int(11) NOT NULL,
  `room_id` int(11) DEFAULT NULL,
  `full_name` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` varchar(255) NOT NULL,
  `room_number` varchar(20) NOT NULL,
  `rental_mode` varchar(20) DEFAULT NULL,
  `emergency_contact` varchar(150) NOT NULL,
  `emergency_phone` varchar(20) NOT NULL,
  `id_type` varchar(50) DEFAULT NULL,
  `id_number` varchar(100) DEFAULT NULL,
  `monthly_due_day` tinyint(2) DEFAULT NULL COMMENT 'Day of month rent is due (1-31)',
  `monthly_rent` decimal(10,2) DEFAULT NULL COMMENT 'Rent amount set by admin',
  `password_hash` varchar(255) NOT NULL,
  `approval_status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `rejection_reason` varchar(500) DEFAULT NULL,
  `move_in_date` date DEFAULT NULL,
  `move_out_date` date DEFAULT NULL,
  `status` enum('active','inactive','pending','moved_out') DEFAULT 'pending',
  `notes` text DEFAULT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tenants`
--

INSERT INTO `tenants` (`id`, `room_id`, `full_name`, `email`, `phone`, `address`, `room_number`, `rental_mode`, `emergency_contact`, `emergency_phone`, `id_type`, `id_number`, `monthly_due_day`, `monthly_rent`, `password_hash`, `approval_status`, `rejection_reason`, `move_in_date`, `move_out_date`, `status`, `notes`, `approved_by`, `approved_at`, `created_at`, `updated_at`) VALUES
(5, 8, 'Ashley Acero', 'hartwaller123@gmail.com', '09496872536', '', '1', 'whole_room', '', '', NULL, NULL, 1, 7000.00, '$2y$10$ToiOmS3YCuXiOByo/WWV1uVc5vasotxebNzeX4ESfIjAf0n6xDYry', 'approved', NULL, '2026-12-01', NULL, 'active', NULL, NULL, NULL, '2026-09-01 20:25:09', '2026-09-01 12:59:55'),
(6, 9, 'Ashe', 'ashleyacero1826@gmail.com', '09111223123123', '', '1', 'whole_room', '', '', NULL, NULL, 5, 7000.00, '$2y$10$KSf2Zl9iS1z3FImjUqcq5.oTwFEAVUXQnmloWWIz1ef0f0zJSX02q', 'approved', NULL, '2026-12-01', NULL, 'active', NULL, NULL, NULL, '2026-09-01 20:35:10', '2026-09-01 12:35:10'),
(7, 10, 'Ash', 'asge.acero.ui@phinmaed.com', '09213123123123', '', '1', 'whole_room', '', '', NULL, NULL, 5, 7000.00, '$2y$10$6j3n0G9Rm/TUj.vt4jZI7.SYnwsqqcvyQ4dfJSTPbGs42z.YG.O9C', 'approved', NULL, '2026-12-01', NULL, 'active', NULL, NULL, NULL, '2026-09-01 20:42:52', '2026-09-01 12:42:52');

-- --------------------------------------------------------

--
-- Table structure for table `tenant_notifications`
--

CREATE TABLE `tenant_notifications` (
  `id` int(11) NOT NULL,
  `tenant_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `type` varchar(50) DEFAULT 'general',
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_users`
--
ALTER TABLE `admin_users`
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `app_settings`
--
--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD KEY `admin_id` (`admin_id`),
  ADD KEY `tenant_id` (`tenant_id`);

--
-- Indexes for table `borrowed_items`
--
ALTER TABLE `borrowed_items`
  ADD KEY `tenant_id` (`tenant_id`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `contracts`
--
ALTER TABLE `contracts`
  ADD KEY `tenant_id` (`tenant_id`),
  ADD KEY `room_id` (`room_id`);

--
-- Indexes for table `inquiries`
--
--
-- Indexes for table `item_damages`
--
ALTER TABLE `item_damages`
  ADD KEY `tenant_id` (`tenant_id`);

--
-- Indexes for table `maintenance_requests`
--
ALTER TABLE `maintenance_requests`
  ADD KEY `tenant_id` (`tenant_id`),
  ADD KEY `room_id` (`room_id`);

--
-- Indexes for table `maintenance_schedules`
--
ALTER TABLE `maintenance_schedules`
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD KEY `tenant_id` (`tenant_id`),
  ADD KEY `room_id` (`room_id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD UNIQUE KEY `branch_room_number` (`branch`,`room_number`);

--
-- Indexes for table `room_images`
--
ALTER TABLE `room_images`
  ADD KEY `idx_room_id` (`room_id`);

--
-- Indexes for table `tenants`
--
ALTER TABLE `tenants`
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `room_id` (`room_id`),
  ADD KEY `approved_by` (`approved_by`);

--
-- Indexes for table `tenant_notifications`
--
ALTER TABLE `tenant_notifications`
  ADD KEY `idx_tenant_notifications_tenant_id` (`tenant_id`),
  ADD KEY `idx_tenant_notifications_created_at` (`created_at`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_users`
--
ALTER TABLE `admin_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `announcements`
--
ALTER TABLE `announcements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `borrowed_items`
--
ALTER TABLE `borrowed_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `contracts`
--
ALTER TABLE `contracts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inquiries`
--
ALTER TABLE `inquiries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `item_damages`
--
ALTER TABLE `item_damages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `maintenance_requests`
--
ALTER TABLE `maintenance_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `maintenance_schedules`
--
ALTER TABLE `maintenance_schedules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `room_images`
--
ALTER TABLE `room_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tenants`
--
ALTER TABLE `tenants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tenant_notifications`
--
ALTER TABLE `tenant_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `announcements`
--
ALTER TABLE `announcements`
  ADD CONSTRAINT `ann_admin_fk` FOREIGN KEY (`created_by`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_admin_fk` FOREIGN KEY (`admin_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `audit_tenant_fk` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `borrowed_items`
--
ALTER TABLE `borrowed_items`
  ADD CONSTRAINT `borrow_tenant_fk` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `contracts`
--
ALTER TABLE `contracts`
  ADD CONSTRAINT `contracts_room_fk` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `contracts_tenant_fk` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `item_damages`
--
ALTER TABLE `item_damages`
  ADD CONSTRAINT `damage_tenant_fk` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `maintenance_requests`
--
ALTER TABLE `maintenance_requests`
  ADD CONSTRAINT `maint_room_fk` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `maint_tenant_fk` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `maintenance_schedules`
--
ALTER TABLE `maintenance_schedules`
  ADD CONSTRAINT `sched_admin_fk` FOREIGN KEY (`created_by`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_room_fk` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `payments_tenant_fk` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `tenants`
--
ALTER TABLE `tenants`
  ADD CONSTRAINT `tenants_approver_fk` FOREIGN KEY (`approved_by`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `tenants_room_fk` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
