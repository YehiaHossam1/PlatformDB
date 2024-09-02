-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema platformdb1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema platformdb1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `platformdb1` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `platformdb1` ;

-- -----------------------------------------------------
-- Table `platformdb1`.`brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `platformdb1`.`brand` (
  `brand_id` INT NOT NULL AUTO_INCREMENT,
  `brand_name` VARCHAR(255) NOT NULL,
  `brand_value_idx_avmv` DECIMAL(10,4) NULL DEFAULT NULL,
  `brand_value_idx_ly` DECIMAL(10,4) NULL DEFAULT NULL,
  PRIMARY KEY (`brand_id`),
  INDEX `Brand` (`brand_id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 134
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `platformdb1`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `platformdb1`.`category` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`category_id`),
  INDEX `Category` (`category_id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `platformdb1`.`dashboard`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `platformdb1`.`dashboard` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `target_value` DECIMAL(10,4) NULL DEFAULT NULL,
  `actual_value` DECIMAL(10,4) NULL DEFAULT NULL,
  `last_update` DATETIME NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `rgm_index` DECIMAL(10,4) NULL DEFAULT NULL,
  `trade_vs_brand_idx` DECIMAL(10,4) NULL DEFAULT NULL,
  `price_change_idx` DECIMAL(10,4) NULL DEFAULT NULL,
  `brand_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `dashboard_ibfk_3` (`brand_id` ASC) VISIBLE,
  CONSTRAINT `dashboard_ibfk_3`
    FOREIGN KEY (`brand_id`)
    REFERENCES `platformdb1`.`brand` (`brand_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 65536
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `platformdb1`.`dates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `platformdb1`.`dates` (
  `date_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NULL DEFAULT NULL,
  `year` INT NULL DEFAULT NULL,
  `month` INT NULL DEFAULT NULL,
  `quarter` INT NULL DEFAULT NULL,
  PRIMARY KEY (`date_id`),
  INDEX `Dates` (`date_id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `platformdb1`.`sku`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `platformdb1`.`sku` (
  `SKU_id` INT NOT NULL AUTO_INCREMENT,
  `SKU_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`SKU_id`),
  INDEX `SKU` (`SKU_id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 554
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `platformdb1`.`sizebracket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `platformdb1`.`sizebracket` (
  `size_bracket_id` INT NOT NULL AUTO_INCREMENT,
  `size_bracket_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`size_bracket_id`),
  INDEX `SizeBracket` (`size_bracket_id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `platformdb1`.`reigon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `platformdb1`.`reigon` (
  `reigon_id` INT NOT NULL AUTO_INCREMENT,
  `reigon_name` VARCHAR(255) NOT NULL,
  `actual_sales_growth` DECIMAL(10,4) NULL DEFAULT NULL,
  `target_sales_growth` DECIMAL(10,2) NULL DEFAULT NULL,
  `market_share` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`reigon_id`),
  INDEX `Reigon` (`reigon_id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `platformdb1`.`rawdata`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `platformdb1`.`rawdata` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `sku_id` INT NULL DEFAULT NULL,
  `date_id` INT NULL DEFAULT NULL,
  `size_bracket_id` INT NULL DEFAULT NULL,
  `category_id` INT NULL DEFAULT NULL,
  `reigon_id` INT NULL DEFAULT NULL,
  `brand_id` INT NULL DEFAULT NULL,
  `value_sales` DECIMAL(10,2) NULL DEFAULT NULL,
  `volume_sales` DECIMAL(10,2) NULL DEFAULT NULL,
  `WOD` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `sku_id` (`sku_id` ASC) VISIBLE,
  INDEX `date_id` (`date_id` ASC) VISIBLE,
  INDEX `size_bracket_id` (`size_bracket_id` ASC) VISIBLE,
  INDEX `reigon_id` (`reigon_id` ASC) VISIBLE,
  INDEX `brand_id` (`brand_id` ASC) VISIBLE,
  INDEX `RawData` (`Id` ASC) VISIBLE,
  INDEX `rawdata_ibfk_4` (`category_id` ASC) VISIBLE,
  CONSTRAINT `rawdata_ibfk_1`
    FOREIGN KEY (`sku_id`)
    REFERENCES `platformdb1`.`sku` (`SKU_id`),
  CONSTRAINT `rawdata_ibfk_2`
    FOREIGN KEY (`date_id`)
    REFERENCES `platformdb1`.`dates` (`date_id`),
  CONSTRAINT `rawdata_ibfk_3`
    FOREIGN KEY (`size_bracket_id`)
    REFERENCES `platformdb1`.`sizebracket` (`size_bracket_id`),
  CONSTRAINT `rawdata_ibfk_4`
    FOREIGN KEY (`category_id`)
    REFERENCES `platformdb1`.`category` (`category_id`),
  CONSTRAINT `rawdata_ibfk_5`
    FOREIGN KEY (`reigon_id`)
    REFERENCES `platformdb1`.`reigon` (`reigon_id`),
  CONSTRAINT `rawdata_ibfk_6`
    FOREIGN KEY (`brand_id`)
    REFERENCES `platformdb1`.`brand` (`brand_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 37583
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `platformdb1`.`derivedcalculations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `platformdb1`.`derivedcalculations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rawdata_id` INT NULL DEFAULT NULL,
  `value_share` DECIMAL(10,4) NULL DEFAULT NULL,
  `volume_share` DECIMAL(10,4) NULL DEFAULT NULL,
  `brand_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `derivedcalculations_ibfk_1` (`rawdata_id` ASC) VISIBLE,
  INDEX `derivedcalculations_ibfk_2` (`brand_id` ASC) VISIBLE,
  CONSTRAINT `derivedcalculations_ibfk_1`
    FOREIGN KEY (`rawdata_id`)
    REFERENCES `platformdb1`.`rawdata` (`Id`),
  CONSTRAINT `derivedcalculations_ibfk_2`
    FOREIGN KEY (`brand_id`)
    REFERENCES `platformdb1`.`brand` (`brand_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 65536
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `platformdb1`.`distributionefficiency`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `platformdb1`.`distributionefficiency` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rawdata_id` INT NULL DEFAULT NULL,
  `distributionEfficiency` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `rawdata_id` (`rawdata_id` ASC) VISIBLE,
  CONSTRAINT `distributionefficiency_ibfk_1`
    FOREIGN KEY (`rawdata_id`)
    REFERENCES `platformdb1`.`rawdata` (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `platformdb1`.`promotionbybrand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `platformdb1`.`promotionbybrand` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `brand_id` INT NULL DEFAULT NULL,
  `uplift` DECIMAL(10,2) NULL DEFAULT NULL,
  `promo_volume_sales_p12m` DECIMAL(10,2) NULL DEFAULT NULL,
  `vsod_p12m` DECIMAL(10,2) NULL DEFAULT NULL,
  `vsod_lya` DECIMAL(10,2) NULL DEFAULT NULL,
  `value_uplift` DECIMAL(10,2) NULL DEFAULT NULL,
  `value_uplift_lya` DECIMAL(10,2) NULL DEFAULT NULL,
  `discount_depth` DECIMAL(10,2) NULL DEFAULT NULL,
  `promo_efficiency` DECIMAL(10,2) NULL DEFAULT NULL,
  `last_update` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `brand_id` (`brand_id` ASC) VISIBLE,
  CONSTRAINT `promotionbybrand_ibfk_1`
    FOREIGN KEY (`brand_id`)
    REFERENCES `platformdb1`.`brand` (`brand_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `platformdb1`.`promotions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `platformdb1`.`promotions` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `rawdata_id` INT NULL DEFAULT NULL,
  `Status` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `rawdata_id` (`rawdata_id` ASC) VISIBLE,
  CONSTRAINT `promotions_ibfk_1`
    FOREIGN KEY (`rawdata_id`)
    REFERENCES `platformdb1`.`rawdata` (`Id`))
ENGINE = InnoDB
AUTO_INCREMENT = 75165
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `platformdb1` ;

-- -----------------------------------------------------
-- procedure UpdateBrandValueIdxAVMV
-- -----------------------------------------------------

DELIMITER $$
USE `platformdb1`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateBrandValueIdxAVMV`()
BEGIN
    -- Step 1: Create a temporary table to calculate average market sales for each brand
    CREATE TEMPORARY TABLE TempAvgMarketSales AS
    SELECT 
        r.brand_id, 
        AVG(r.value_sales) AS avg_market_sales
    FROM 
        RAWDATA r
    GROUP BY 
        r.brand_id;

    -- Step 2: Calculate the overall average market sales (denominator)
    SET @overall_avg_market_sales = (
        SELECT AVG(r.value_sales)
        FROM RAWDATA r
    );

    -- Step 3: Update the brand table with the calculated brand_value_idx_avmv
    UPDATE brand b
    JOIN TempAvgMarketSales t ON b.brand_id = t.brand_id
    SET b.brand_value_idx_avmv = t.avg_market_sales / @overall_avg_market_sales;

    -- Step 4: Drop the temporary table to clean up
    DROP TEMPORARY TABLE IF EXISTS TempAvgMarketSales;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure UpdateBrandValueIdxLY
-- -----------------------------------------------------

DELIMITER $$
USE `platformdb1`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateBrandValueIdxLY`()
BEGIN
    -- Step 1: Create a temporary table to calculate last year's and this year's sales for each brand
    CREATE TEMPORARY TABLE TempLastYearSales AS
    WITH cte1 AS (
        SELECT
            r.brand_id, 
            SUM(CASE WHEN d.year = YEAR(CURDATE()) - 1 THEN r.value_sales ELSE 0 END) AS last_year_sales,
            SUM(CASE WHEN d.year = YEAR(CURDATE()) THEN r.value_sales ELSE 0 END) AS this_year_sales
        FROM 
            RAWDATA r
        INNER JOIN dates d ON r.date_id = d.date_id
        GROUP BY 
            r.brand_id
    )
    SELECT 
        brand_id,
        CASE 
            WHEN last_year_sales = 0 THEN 0
            ELSE this_year_sales / last_year_sales 
        END AS brand_value_idx_ly
    FROM 
        cte1;

    -- Step 2: Update the brand table with the calculated brand_value_idx_ly
    UPDATE brand b
    JOIN TempLastYearSales t ON b.brand_id = t.brand_id
    SET b.brand_value_idx_ly = t.brand_value_idx_ly;

    -- Step 3: Drop the temporary table to clean up
    DROP TEMPORARY TABLE IF EXISTS TempLastYearSales;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure UpdateMarketShare
-- -----------------------------------------------------

DELIMITER $$
USE `platformdb1`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateMarketShare`()
begin 
	create temporary table TempMarketShare as 
    
	select reigon_id,
    sum(value_sales)/ (select sum(value_sales) From rawdata) as market_share 
    From rawdata Group by reigon_id;
    
    update reigon r
    JOIN TempMarketShare t ON r.reigon_id = t.reigon_id
    SET r.market_share = t.market_share;

    -- Step 3: Drop the temporary table to clean up
    DROP TEMPORARY TABLE IF EXISTS TempMarketShare;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure UpdateRegionSalesGrowth
-- -----------------------------------------------------

DELIMITER $$
USE `platformdb1`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateRegionSalesGrowth`()
Begin
	Create Temporary table TempSalesGrowth as 
	with reigon_sales_by_year as(
	select reigon_id,
		sum(case when year = YEAR(CURDATE()) - 1 then value_sales end)  last_year_sales,
		sum(case when year = YEAR(CURDATE()) then value_sales end) as current_year_sales
	From 
		rawdata r join dates d 
	On 
		r.date_id = d.date_id
	group by 
		reigon_id)
		
	select reigon_id,
		(current_year_sales - last_year_sales)/last_year_sales as actual_sales_growth
	From reigon_sales_by_year;
    
    -- Step 2: Update the brand table with the calculated brand_value_idx_ly
    UPDATE Reigon r
    JOIN TempSalesGrowth t ON r.reigon_id = t.reigon_id
    SET r.actual_sales_growth = t.actual_sales_growth;

    -- Step 3: Drop the temporary table to clean up
    DROP TEMPORARY TABLE IF EXISTS TempSalesGrowth;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure rgm_index
-- -----------------------------------------------------

DELIMITER $$
USE `platformdb1`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `rgm_index`()
Begin
	drop table if exists TempResults;
	CREATE TEMPORARY TABLE TempResults AS

	SELECT 
		brand_id,
		case 
			when volume_share = 0 then 0
			else (value_share / volume_share) 
		end AS rgm_index
	From 
		DerivedCalculations d;
	
	insert into dashboard(brand_id,rgm_index)
		SELECT brand_id, rgm_index 
		FROM TempResults;
    
	DROP TEMPORARY TABLE IF EXISTS TempResults;
END$$

DELIMITER ;
USE `platformdb1`;

DELIMITER $$
USE `platformdb1`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `platformdb1`.`before_insert_dim_date`
BEFORE INSERT ON `platformdb1`.`dates`
FOR EACH ROW
BEGIN
    SET NEW.year = YEAR(NEW.date);
    SET NEW.month = MONTH(NEW.date);
    SET NEW.quarter = QUARTER(NEW.date);
END$$

USE `platformdb1`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `platformdb1`.`distribution_efficiency_insertion`
AFTER INSERT ON `platformdb1`.`rawdata`
FOR EACH ROW
BEGIN
    DECLARE dist_eff DECIMAL(10, 2);
    
    -- Calculate distribution efficiency
    SET dist_eff = NEW.value_sales / NEW.wod;

    -- Insert the calculated value into the distribution_efficiency table
    INSERT INTO distribution_efficiency (rawdata_id, distribution_efficiency)
    VALUES (NEW.ID, dist_eff);
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
