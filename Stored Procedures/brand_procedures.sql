use platformdb1;

select * from brand;

alter table brand add column value_share decimal(10,5);
alter table brand add column volume_share decimal(10,5);

alter table brand add column brand_fair_share decimal(10,5);

drop PROCEDURE if exists AddBrandValueShare;
DELIMITER $$
CREATE PROCEDURE AddBrandValueShare(
)
BEGIN
	DECLARE total_value_sales DECIMAL(18, 2);
    
	-- Materialize the total value_sales from TempFilteredData into a variable
    SELECT SUM(value_sales) INTO total_value_sales FROM TempFilteredData;
    
    -- Create the BrandMarketshare temporary table
    CREATE TEMPORARY TABLE BrandMarketshare AS
    SELECT 
        r.brand_id, 
        SUM(r.value_sales) / total_value_sales AS market_share
    FROM 
        TempFilteredData r
    GROUP BY 
        r.brand_id;

    -- Update the brand table with the calculated market share
    UPDATE brand b
    JOIN BrandMarketshare bms ON b.brand_id = bms.brand_id
    SET b.value_share = bms.market_share;

    -- Clean up: Drop the temporary tables
    DROP TEMPORARY TABLE IF EXISTS BrandMarketshare;
END $$
DELIMITER ;

drop PROCEDURE if exists AddBrandVolumeShare;
DELIMITER $$
CREATE PROCEDURE AddBrandVolumeShare(
)
BEGIN
	DECLARE total_volume_sales DECIMAL(18, 2);
    
	-- Materialize the total value_sales from TempFilteredData into a variable
    SELECT SUM(volume_sales) INTO total_volume_sales FROM TempFilteredData;
    
    -- Create the BrandMarketshare temporary table
    CREATE TEMPORARY TABLE BrandMarketshare AS
    SELECT 
        r.brand_id, 
        SUM(r.volume_sales) / total_volume_sales AS market_share
    FROM 
        TempFilteredData r
    GROUP BY 
        r.brand_id;

    -- Update the brand table with the calculated market share
    UPDATE brand b
    JOIN BrandMarketshare bms ON b.brand_id = bms.brand_id
    SET b.volume_share = bms.market_share;

    -- Clean up: Drop the temporary tables
    DROP TEMPORARY TABLE IF EXISTS BrandMarketshare;
END $$
DELIMITER ;

drop PROCEDURE if exists CalculateBrandFairShare;
DELIMITER $$
CREATE PROCEDURE CalculateBrandFairShare(
)
BEGIN
    DECLARE total_value_sales DECIMAL(18, 2);
	DECLARE total_brands INT;

    -- Step 2: Materialize the total value_sales from TempFilteredData into a variable
    SELECT SUM(value_sales) INTO total_value_sales FROM TempFilteredData;

    -- Step 3: Create a temporary table to store the competitors' market share for each brand
    CREATE TEMPORARY TABLE BrandCompetitorsShare AS
    SELECT 
        r.brand_id,
        1 - (SUM(r.value_sales) / total_value_sales) AS competitors_market_share
    FROM 
        TempFilteredData r
    GROUP BY 
        r.brand_id;

    -- Step 4: Calculate the total number of brands (used to calculate fair share)
    SELECT COUNT(*) - 1 INTO total_brands FROM brand;

    -- Step 5: Update the brand table with the calculated brand_fair_share
    UPDATE brand b
    JOIN BrandCompetitorsShare bcs ON b.brand_id = bcs.brand_id
    SET b.brand_fair_share = bcs.competitors_market_share / total_brands;

    -- Step 6: Clean up - Drop the temporary tables
    DROP TEMPORARY TABLE IF EXISTS BrandCompetitorsShare;
END $$

DELIMITER ;


drop PROCEDURE if exists brand_values;
DELIMITER $$
CREATE PROCEDURE brand_values(
    IN filterRegion VARCHAR(50),
    IN filterSegment VARCHAR(50),
    IN filterSku VARCHAR(50),
    IN filterBrand VARCHAR(50),
    IN filterSizebracket VARCHAR(50)
)
BEGIN
    -- Step 1: Prepare the filtered data
    CALL PrepareFilteredData(filterRegion, filterSegment, filterSku, filterBrand, filterSizebracket);
	call AddBrandValueShare();
	call AddBrandVolumeShare();
	CALL CalculateBrandFairShare ();
    
    select * from brand;
    DROP TEMPORARY TABLE IF EXISTS TempFilteredData;
END $$
DELIMITER ; 

call brand_values(Null,Null,Null,NULL,Null);
