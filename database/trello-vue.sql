-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 13, 2021 at 07:16 AM
-- Server version: 5.7.14
-- PHP Version: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `trello-vue`
--

-- --------------------------------------------------------

--
-- Table structure for table `assignments`
--

CREATE TABLE `assignments` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `boards`
--

CREATE TABLE `boards` (
  `id` int(10) UNSIGNED NOT NULL,
  `board_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `starred` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `boards`
--

INSERT INTO `boards` (`id`, `board_name`, `description`, `starred`, `created_at`, `updated_at`) VALUES
(1, 'Software Development', 'Accomplishments under Software Development Team', 0, '2019-11-24 02:44:55', '2019-11-24 02:44:55'),
(2, 'Website Development', 'Accomplishment under Web Department', 0, '2019-11-24 02:45:26', '2019-11-24 02:45:26'),
(3, 'Agile Sprint Board', 'Agile Development', 0, '2019-11-24 02:46:24', '2019-11-24 02:46:24');

-- --------------------------------------------------------

--
-- Table structure for table `board_lists`
--

CREATE TABLE `board_lists` (
  `id` int(10) UNSIGNED NOT NULL,
  `boards_id` int(11) NOT NULL,
  `list_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_created` date NOT NULL,
  `archived` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `board_lists`
--

INSERT INTO `board_lists` (`id`, `boards_id`, `list_name`, `date_created`, `archived`, `created_at`, `updated_at`) VALUES
(1, 1, 'Done', '2019-11-24', 0, '2019-11-24 02:53:20', '2019-11-24 02:53:20'),
(2, 1, 'Doing', '2019-11-24', 0, '2019-11-24 02:54:21', '2019-11-24 02:54:21'),
(3, 1, 'To Do', '2019-11-24', 0, '2019-11-24 02:56:09', '2019-11-24 02:56:09'),
(4, 1, 'For Testing', '2019-11-24', 0, '2019-11-24 03:13:14', '2019-11-24 03:13:14');

-- --------------------------------------------------------

--
-- Table structure for table `board_members`
--

CREATE TABLE `board_members` (
  `id` int(10) UNSIGNED NOT NULL,
  `boards_id` int(11) NOT NULL,
  `users_id` int(11) NOT NULL,
  `date_joined` date NOT NULL,
  `permissions_id` int(11) DEFAULT NULL,
  `starred` int(11) NOT NULL,
  `is_owner` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `board_members`
--

INSERT INTO `board_members` (`id`, `boards_id`, `users_id`, `date_joined`, `permissions_id`, `starred`, `is_owner`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2019-11-24', NULL, 1, 1, '2019-11-24 02:44:55', '2019-11-24 02:46:30'),
(2, 2, 1, '2019-11-24', NULL, 0, 1, '2019-11-24 02:45:26', '2019-11-24 02:45:26'),
(3, 3, 1, '2019-11-24', NULL, 1, 1, '2019-11-24 02:46:24', '2019-11-24 02:46:27'),
(4, 1, 2, '2019-11-24', NULL, 0, 0, '2019-11-24 03:16:00', '2019-11-24 03:16:00');

-- --------------------------------------------------------

--
-- Table structure for table `cards`
--

CREATE TABLE `cards` (
  `id` int(10) UNSIGNED NOT NULL,
  `board_lists_id` int(11) NOT NULL,
  `card_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_created` date NOT NULL,
  `due_date` date DEFAULT NULL,
  `labels_id` int(11) NOT NULL,
  `archived` int(11) NOT NULL,
  `attachment` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cards`
--

INSERT INTO `cards` (`id`, `board_lists_id`, `card_name`, `description`, `date_created`, `due_date`, `labels_id`, `archived`, `attachment`, `created_at`, `updated_at`) VALUES
(1, 1, 'Navigation Bar', 'Positioning of menu items fixed', '2019-11-24', '2019-11-04', 1, 0, 'images/images.png', '2019-11-24 02:59:59', '2019-11-24 03:10:30'),
(2, 2, 'Users Portal', 'Portal for the users to check their record', '2019-11-24', '2019-11-30', 2, 0, NULL, '2019-11-24 03:06:28', '2019-11-24 03:10:43'),
(3, 3, 'Add to Cart function won\'t work', 'To check the reason', '2019-11-24', '2019-11-22', 4, 0, 'images/CTA-Add-to-Cart-Button-JPG-Graphic-Cave-1080x628.jpg', '2019-11-24 03:07:10', '2019-11-24 03:12:22'),
(4, 1, 'Admin Portal', 'Admin can manage the user', '2019-11-24', '2019-10-02', 1, 1, 'images/images.jpg', '2019-11-24 03:17:38', '2019-11-24 03:23:14');

-- --------------------------------------------------------

--
-- Table structure for table `card_assignees`
--

CREATE TABLE `card_assignees` (
  `id` int(10) UNSIGNED NOT NULL,
  `cards_id` int(11) NOT NULL,
  `users_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `checklists`
--

CREATE TABLE `checklists` (
  `id` int(10) UNSIGNED NOT NULL,
  `cards_id` int(11) NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `checklist_items`
--

CREATE TABLE `checklist_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `checklists_id` int(11) NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `completed` int(11) NOT NULL,
  `date_finished` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `colors`
--

CREATE TABLE `colors` (
  `id` int(10) UNSIGNED NOT NULL,
  `color_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `colors`
--

INSERT INTO `colors` (`id`, `color_name`, `created_at`, `updated_at`) VALUES
(1, '#61BD4F', '2019-03-23 04:49:49', '2019-03-23 04:49:49'),
(2, '#FF9F1A', '2019-03-23 04:49:49', '2019-03-23 04:49:49'),
(3, '#F2D600', '2019-03-23 04:49:49', '2019-03-23 04:49:49'),
(4, '#EB5A46', '2019-03-23 04:49:49', '2019-03-23 04:49:49'),
(5, '#C377E0', '2019-03-23 04:49:49', '2019-03-23 04:49:49'),
(6, '#0079BF', '2019-03-23 04:49:49', '2019-03-23 04:49:49'),
(7, '#00C2E0', '2019-03-23 04:49:49', '2019-03-23 04:49:49'),
(8, '#51E898', '2019-03-23 04:49:49', '2019-03-23 04:49:49');

-- --------------------------------------------------------

--
-- Table structure for table `labels`
--

CREATE TABLE `labels` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `colors_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `labels`
--

INSERT INTO `labels` (`id`, `name`, `colors_id`, `created_at`, `updated_at`) VALUES
(1, 'Done', 1, '2019-03-23 04:49:49', '2019-03-23 04:49:49'),
(2, 'In-process', 2, '2019-03-23 04:49:49', '2019-03-23 04:49:49'),
(3, 'Stuck', 4, '2019-03-31 08:03:13', '2019-03-31 08:03:13'),
(4, 'Pending', 7, '2019-03-31 08:04:09', '2019-04-07 04:12:12'),
(7, 'Back Job', 3, '2019-04-13 04:01:58', '2019-04-13 04:01:58'),
(6, 'Testing', 8, '2019-04-02 06:00:01', '2019-04-13 04:01:40');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2019_03_22_145036_create_users_table', 1),
(2, '2019_03_22_145632_create_password_resets_table', 1),
(3, '2019_03_22_145809_create_assignments_table', 1),
(4, '2019_03_22_145958_create_board_lists_table', 1),
(5, '2019_03_22_150346_create_cards_table', 1),
(6, '2019_03_23_133902_create_labels_table', 2),
(7, '2019_03_31_141254_create_checklists_table', 3),
(8, '2019_03_31_142732_create_colors_table', 4),
(9, '2019_04_09_072312_remove_field_in_checklists', 5),
(10, '2019_04_09_073048_create_checklist_items_table', 6),
(11, '2019_04_09_073638_create_checklist_items_table', 7),
(12, '2019_04_13_111228_create_boards_table', 8),
(13, '2019_09_21_113501_create_permissions_table', 9),
(14, '2019_09_21_114157_create_board_members_table', 10),
(15, '2019_09_21_115304_create_card_assignees_table', 11);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Admin', NULL, NULL),
(2, 'Normal', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Journey Dagoc', 'jmdhagz@gmail.com', '$2y$10$C.vBDgWeWGmW6wrvl7BgJOmYKPdIYlmQkHFT9tNql01Qsuo1MJUq2', '8ooyxr18ElK8FE90fPCXSsd1YOiUulii0LxkWCYCsFxJGHyB6G2HCXoUpOXt', '2019-09-21 04:07:42', '2019-09-21 04:07:42'),
(2, 'Theresa Bacala', 'jmdagoc@gmail.com', '$2y$10$733Pk9.O14f1yfL7K9xhMOpOnredIRsOE.9Ei42DcYStUAIKs8yo2', NULL, '2019-10-08 06:41:00', '2019-10-08 06:41:00'),
(3, 'John Doe', 'johndoe@gmail.com', '$2y$10$Q959ybBnGL2HjM3z9uXLSeDETLM2FsfpqC2chZFfv79D3AANVy9CS', NULL, '2019-10-14 05:48:21', '2019-10-14 05:48:21');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assignments`
--
ALTER TABLE `assignments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `boards`
--
ALTER TABLE `boards`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `board_lists`
--
ALTER TABLE `board_lists`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `board_members`
--
ALTER TABLE `board_members`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cards`
--
ALTER TABLE `cards`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `card_assignees`
--
ALTER TABLE `card_assignees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `checklists`
--
ALTER TABLE `checklists`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `checklist_items`
--
ALTER TABLE `checklist_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `colors`
--
ALTER TABLE `colors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `labels`
--
ALTER TABLE `labels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assignments`
--
ALTER TABLE `assignments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `boards`
--
ALTER TABLE `boards`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `board_lists`
--
ALTER TABLE `board_lists`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `board_members`
--
ALTER TABLE `board_members`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `cards`
--
ALTER TABLE `cards`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `card_assignees`
--
ALTER TABLE `card_assignees`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `checklists`
--
ALTER TABLE `checklists`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `checklist_items`
--
ALTER TABLE `checklist_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `colors`
--
ALTER TABLE `colors`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `labels`
--
ALTER TABLE `labels`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
