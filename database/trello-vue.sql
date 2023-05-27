-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 27, 2023 at 04:16 AM
-- Server version: 5.7.31
-- PHP Version: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
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
(1, 'Software Solutions Team', 'SST', 0, '2023-05-25 17:22:01', '2023-05-25 17:22:01'),
(2, 'Tekspert', 'haha', 0, '2023-05-25 18:27:17', '2023-05-25 18:27:17'),
(3, 'QA Board', 'for QA', 0, '2023-05-26 18:49:05', '2023-05-26 18:49:05');

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
(1, 1, 'Done', '2023-05-26', 0, '2023-05-25 17:22:34', '2023-05-26 01:44:41'),
(2, 1, 'For QA', '2023-05-26', 0, '2023-05-25 17:23:12', '2023-05-26 01:44:46'),
(3, 1, 'In Progress', '2023-05-26', 0, '2023-05-25 17:23:32', '2023-05-26 01:45:04'),
(4, 1, 'Bug', '2023-05-26', 0, '2023-05-25 17:24:58', '2023-05-26 01:44:52'),
(5, 1, 'Ticket', '2023-05-26', 0, '2023-05-25 17:38:18', '2023-05-26 06:23:19');

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
(1, 1, 1, '2023-05-26', NULL, 1, 1, '2023-05-25 17:22:01', '2023-05-26 06:22:57'),
(2, 2, 1, '2023-05-26', NULL, 0, 1, '2023-05-25 18:27:17', '2023-05-25 18:27:17'),
(3, 3, 4, '2023-05-27', NULL, 0, 1, '2023-05-26 18:49:05', '2023-05-26 18:49:05'),
(5, 1, 4, '2023-05-27', NULL, 1, 0, '2023-05-26 19:17:52', '2023-05-26 19:25:52'),
(6, 1, 3, '2023-05-27', NULL, 0, 0, '2023-05-26 19:37:00', '2023-05-26 19:37:00');

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
  `labels_id` int(11) NOT NULL DEFAULT '0',
  `archived` int(11) NOT NULL DEFAULT '0',
  `ticket_id` int(11) NOT NULL DEFAULT '0',
  `attachment` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cards`
--

INSERT INTO `cards` (`id`, `board_lists_id`, `card_name`, `description`, `date_created`, `due_date`, `labels_id`, `archived`, `ticket_id`, `attachment`, `created_at`, `updated_at`) VALUES
(1, 5, 'System Bug', 'To be fixed ASAP', '2023-05-27', NULL, 8, 0, 1, NULL, '2023-05-26 20:04:04', '2023-05-26 20:04:04'),
(2, 5, 'Production Bug', 'To be fixed ASAP!', '2023-05-27', NULL, 8, 0, 2, NULL, '2023-05-26 20:13:33', '2023-05-26 20:13:33');

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

--
-- Dumping data for table `checklists`
--

INSERT INTO `checklists` (`id`, `cards_id`, `description`, `created_at`, `updated_at`) VALUES
(1, 7, 'Accounting', '2023-05-26 01:12:18', '2023-05-26 01:28:00'),
(2, 7, 'HRMS', '2023-05-26 01:29:20', '2023-05-26 01:29:20');

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

--
-- Dumping data for table `checklist_items`
--

INSERT INTO `checklist_items` (`id`, `checklists_id`, `description`, `completed`, `date_finished`, `created_at`, `updated_at`) VALUES
(2, 1, 'aseraser', 1, '2023-05-26', '2023-05-26 01:25:22', '2023-05-26 01:27:48'),
(5, 1, 'sdsd', 0, NULL, '2023-05-26 01:39:34', '2023-05-26 01:39:34'),
(4, 1, 'testse', 1, '2023-05-26', '2023-05-26 01:27:43', '2023-05-26 01:39:30'),
(6, 2, '1111', 0, NULL, '2023-05-26 01:40:05', '2023-05-26 01:40:05');

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
(3, 'Pending', 4, '2019-03-31 08:03:13', '2023-05-24 07:17:56'),
(4, 'For QA', 7, '2019-03-31 08:04:09', '2019-04-07 04:12:12'),
(8, 'Bug', 5, '2023-05-25 17:39:29', '2023-05-25 17:39:29');

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
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Support', '2023-05-26 01:26:31', '2023-05-26 01:26:48'),
(2, 'Developer', '2023-05-26 01:26:31', '2023-05-26 01:26:48'),
(3, 'QA', '2023-05-26 01:26:31', '2023-05-26 01:26:48');

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `board_list_id` int(11) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tickets`
--

INSERT INTO `tickets` (`id`, `name`, `description`, `board_list_id`, `date`, `created_at`, `updated_at`) VALUES
(1, 'System Bug', 'To be fixed ASAP', 5, '2023-05-27 00:00:00', '2023-05-26 20:04:04', '2023-05-26 20:04:04'),
(2, 'Production Bug', 'To be fixed ASAP!', 5, '2023-05-27 00:00:00', '2023-05-26 20:13:33', '2023-05-26 20:13:33');

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
(4, 'Jeffrey Way', 'jeffreyway@gmail.com', '$2y$10$wuhmavyxh.V3uN4aP9rXveXkwTCku4Yq.Xtptv3HsSJCn5jv4B6tG', NULL, '2023-05-26 18:47:26', '2023-05-26 18:47:26'),
(3, 'John Doe', 'johndoe@gmail.com', '$2y$10$Q959ybBnGL2HjM3z9uXLSeDETLM2FsfpqC2chZFfv79D3AANVy9CS', NULL, '2019-10-14 05:48:21', '2019-10-14 05:48:21');

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`id`, `user_id`, `role_id`, `created_at`, `updated_at`) VALUES
(1, 1, 2, '2023-05-26 01:27:58', '2023-05-26 01:28:08'),
(2, 1, 3, '2023-05-26 06:02:37', '2023-05-26 06:02:48'),
(4, 4, 1, '2023-05-26 06:02:37', '2023-05-26 06:02:48');

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
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`id`);

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `board_members`
--
ALTER TABLE `board_members`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `cards`
--
ALTER TABLE `cards`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `card_assignees`
--
ALTER TABLE `card_assignees`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `checklists`
--
ALTER TABLE `checklists`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `checklist_items`
--
ALTER TABLE `checklist_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `colors`
--
ALTER TABLE `colors`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `labels`
--
ALTER TABLE `labels`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

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
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
