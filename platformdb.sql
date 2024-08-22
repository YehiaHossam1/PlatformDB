-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 20, 2024 at 09:13 AM
-- Server version: 9.0.1
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `platformdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `brand`
--

CREATE TABLE `brand` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `brand_equity` decimal(10,2) DEFAULT NULL,
  `brand_awareness` decimal(5,2) DEFAULT NULL,
  `brand_perception` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `market_id` int DEFAULT NULL,
  `last_update` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `description` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `brandvaluecreation`
--

CREATE TABLE `brandvaluecreation` (
  `id` int NOT NULL,
  `brand_id` int DEFAULT NULL,
  `value_index` decimal(5,2) DEFAULT NULL,
  `last_update` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `consumerdynamics`
--

CREATE TABLE `consumerdynamics` (
  `id` int NOT NULL,
  `market_id` int DEFAULT NULL,
  `dynamic_metric` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `value` decimal(10,2) DEFAULT NULL,
  `last_update` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dashboard`
--

CREATE TABLE `dashboard` (
  `id` int NOT NULL,
  `kpi_id` int DEFAULT NULL,
  `target_value` decimal(10,2) DEFAULT NULL,
  `actual_value` decimal(10,2) DEFAULT NULL,
  `last_update` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `description` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `distributionefficiency`
--

CREATE TABLE `distributionefficiency` (
  `id` int NOT NULL,
  `raw_data_id` int NOT NULL,
  `distribution_efficiency` decimal(10,2) DEFAULT NULL,
  `market_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kpi`
--

CREATE TABLE `kpi` (
  `id` int NOT NULL,
  `kpi_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `market`
--

CREATE TABLE `market` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `marketchannelperformance`
--

CREATE TABLE `marketchannelperformance` (
  `id` int NOT NULL,
  `market_id` int DEFAULT NULL,
  `channel_performance_metric` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `value` decimal(10,2) DEFAULT NULL,
  `last_update` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `marketinsights`
--

CREATE TABLE `marketinsights` (
  `id` int NOT NULL,
  `insight_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `marketperformance`
--

CREATE TABLE `marketperformance` (
  `id` int NOT NULL,
  `market_id` int DEFAULT NULL,
  `performance_metric` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `value` decimal(10,2) DEFAULT NULL,
  `last_update` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `marketsegment`
--

CREATE TABLE `marketsegment` (
  `id` int NOT NULL,
  `market_id` int DEFAULT NULL,
  `segment_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `platformdesign`
--

CREATE TABLE `platformdesign` (
  `id` int NOT NULL,
  `design_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pricingstrategy`
--

CREATE TABLE `pricingstrategy` (
  `id` int NOT NULL,
  `strategy_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `productsegment`
--

CREATE TABLE `productsegment` (
  `id` int NOT NULL,
  `segment_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `promotionbybrand`
--

CREATE TABLE `promotionbybrand` (
  `id` int NOT NULL,
  `brand_id` int DEFAULT NULL,
  `uplift` decimal(10,2) DEFAULT NULL,
  `promo_volume_sales_p12m` decimal(10,2) DEFAULT NULL,
  `vsod_p12m` decimal(10,2) DEFAULT NULL,
  `vsod_lya` decimal(10,2) DEFAULT NULL,
  `value_uplift` decimal(10,2) DEFAULT NULL,
  `value_uplift_lya` decimal(10,2) DEFAULT NULL,
  `discount_depth` decimal(10,2) DEFAULT NULL,
  `promo_efficiency` decimal(10,2) DEFAULT NULL,
  `last_update` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `promotiontype`
--

CREATE TABLE `promotiontype` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rawdata`
--

CREATE TABLE `rawdata` (
  `id` int NOT NULL,
  `value_sales` decimal(10,2) DEFAULT NULL,
  `volume_sales` decimal(10,2) DEFAULT NULL,
  `value_share` decimal(5,2) DEFAULT NULL,
  `volume_share` decimal(5,2) DEFAULT NULL,
  `value_sales_iya` decimal(10,2) DEFAULT NULL,
  `volume_sales_iya` decimal(10,2) DEFAULT NULL,
  `wtd` decimal(5,2) DEFAULT NULL,
  `market_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tradechannel`
--

CREATE TABLE `tradechannel` (
  `id` int NOT NULL,
  `channel_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trademanagement`
--

CREATE TABLE `trademanagement` (
  `id` int NOT NULL,
  `market_id` int DEFAULT NULL,
  `trade_score` decimal(5,2) DEFAULT NULL,
  `last_update` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `userentry`
--

CREATE TABLE `userentry` (
  `id` int NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `brand`
--
ALTER TABLE `brand`
  ADD PRIMARY KEY (`id`),
  ADD KEY `market_id` (`market_id`);

--
-- Indexes for table `brandvaluecreation`
--
ALTER TABLE `brandvaluecreation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `brand_id` (`brand_id`);

--
-- Indexes for table `consumerdynamics`
--
ALTER TABLE `consumerdynamics`
  ADD PRIMARY KEY (`id`),
  ADD KEY `market_id` (`market_id`);

--
-- Indexes for table `dashboard`
--
ALTER TABLE `dashboard`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kpi_id` (`kpi_id`);

--
-- Indexes for table `distributionefficiency`
--
ALTER TABLE `distributionefficiency`
  ADD PRIMARY KEY (`id`),
  ADD KEY `raw_data_id` (`raw_data_id`),
  ADD KEY `market_id` (`market_id`);

--
-- Indexes for table `kpi`
--
ALTER TABLE `kpi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `market`
--
ALTER TABLE `market`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `marketchannelperformance`
--
ALTER TABLE `marketchannelperformance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `market_id` (`market_id`);

--
-- Indexes for table `marketinsights`
--
ALTER TABLE `marketinsights`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `marketperformance`
--
ALTER TABLE `marketperformance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `market_id` (`market_id`);

--
-- Indexes for table `marketsegment`
--
ALTER TABLE `marketsegment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `market_id` (`market_id`);

--
-- Indexes for table `platformdesign`
--
ALTER TABLE `platformdesign`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pricingstrategy`
--
ALTER TABLE `pricingstrategy`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `productsegment`
--
ALTER TABLE `productsegment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `promotionbybrand`
--
ALTER TABLE `promotionbybrand`
  ADD PRIMARY KEY (`id`),
  ADD KEY `brand_id` (`brand_id`);

--
-- Indexes for table `promotiontype`
--
ALTER TABLE `promotiontype`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rawdata`
--
ALTER TABLE `rawdata`
  ADD PRIMARY KEY (`id`),
  ADD KEY `market_id` (`market_id`);

--
-- Indexes for table `tradechannel`
--
ALTER TABLE `tradechannel`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trademanagement`
--
ALTER TABLE `trademanagement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `market_id` (`market_id`);

--
-- Indexes for table `userentry`
--
ALTER TABLE `userentry`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `brand`
--
ALTER TABLE `brand`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `brandvaluecreation`
--
ALTER TABLE `brandvaluecreation`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `consumerdynamics`
--
ALTER TABLE `consumerdynamics`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dashboard`
--
ALTER TABLE `dashboard`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `distributionefficiency`
--
ALTER TABLE `distributionefficiency`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kpi`
--
ALTER TABLE `kpi`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `market`
--
ALTER TABLE `market`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `marketchannelperformance`
--
ALTER TABLE `marketchannelperformance`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `marketinsights`
--
ALTER TABLE `marketinsights`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `marketperformance`
--
ALTER TABLE `marketperformance`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `marketsegment`
--
ALTER TABLE `marketsegment`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `platformdesign`
--
ALTER TABLE `platformdesign`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pricingstrategy`
--
ALTER TABLE `pricingstrategy`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `productsegment`
--
ALTER TABLE `productsegment`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `promotionbybrand`
--
ALTER TABLE `promotionbybrand`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `promotiontype`
--
ALTER TABLE `promotiontype`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rawdata`
--
ALTER TABLE `rawdata`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tradechannel`
--
ALTER TABLE `tradechannel`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trademanagement`
--
ALTER TABLE `trademanagement`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `userentry`
--
ALTER TABLE `userentry`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `brand`
--
ALTER TABLE `brand`
  ADD CONSTRAINT `brand_ibfk_1` FOREIGN KEY (`market_id`) REFERENCES `market` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `brandvaluecreation`
--
ALTER TABLE `brandvaluecreation`
  ADD CONSTRAINT `brandvaluecreation_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `consumerdynamics`
--
ALTER TABLE `consumerdynamics`
  ADD CONSTRAINT `consumerdynamics_ibfk_1` FOREIGN KEY (`market_id`) REFERENCES `market` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `dashboard`
--
ALTER TABLE `dashboard`
  ADD CONSTRAINT `dashboard_ibfk_1` FOREIGN KEY (`kpi_id`) REFERENCES `kpi` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `distributionefficiency`
--
ALTER TABLE `distributionefficiency`
  ADD CONSTRAINT `distributionefficiency_ibfk_1` FOREIGN KEY (`raw_data_id`) REFERENCES `rawdata` (`id`),
  ADD CONSTRAINT `distributionefficiency_ibfk_2` FOREIGN KEY (`market_id`) REFERENCES `market` (`id`);

--
-- Constraints for table `marketchannelperformance`
--
ALTER TABLE `marketchannelperformance`
  ADD CONSTRAINT `marketchannelperformance_ibfk_1` FOREIGN KEY (`market_id`) REFERENCES `market` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `marketperformance`
--
ALTER TABLE `marketperformance`
  ADD CONSTRAINT `marketperformance_ibfk_1` FOREIGN KEY (`market_id`) REFERENCES `market` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `marketsegment`
--
ALTER TABLE `marketsegment`
  ADD CONSTRAINT `marketsegment_ibfk_1` FOREIGN KEY (`market_id`) REFERENCES `market` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `promotionbybrand`
--
ALTER TABLE `promotionbybrand`
  ADD CONSTRAINT `promotionbybrand_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rawdata`
--
ALTER TABLE `rawdata`
  ADD CONSTRAINT `rawdata_ibfk_1` FOREIGN KEY (`market_id`) REFERENCES `market` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trademanagement`
--
ALTER TABLE `trademanagement`
  ADD CONSTRAINT `trademanagement_ibfk_1` FOREIGN KEY (`market_id`) REFERENCES `market` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
