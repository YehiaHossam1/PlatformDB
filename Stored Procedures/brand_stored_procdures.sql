use platformdb1;

## adding the brand_value_idx_avmv to the brand table 
ALTER TABLE brand
ADD COLUMN brand_value_idx_avmv DECIMAL(10, 4);

## adding the brand_value_idx_ly to the brand table 
ALTER TABLE brand
ADD COLUMN brand_value_idx_ly DECIMAL(10, 4);

# adding rgm_index_value
alter table brand 
add column rgm_index decimal(10,2);


# adding value_sales_last_year 
alter table brand 
add column value_sales_last_year decimal(10,2);

# adding value_sales_this_year 
alter table brand 
add column value_sales_this_year decimal(10,2);

drop PROCEDURE if exists UpdateBrandValueIdxAVMV;
DELIMITER $$
CREATE PROCEDURE UpdateBrandValueIdxAVMV(
	IN filterRegion VARCHAR(50),
    IN filterSegment VARCHAR(50),
    IN filterSku VARCHAR(50),
    IN filterBrand VARCHAR(50),
    IN filterSizebracket VARCHAR(50)
)
BEGIN
    -- Step 1: Create a temporary table to calculate average market sales for each brand
    
    call PrepareFilteredData(filterRegion, filterSegment, filterSku, filterBrand, filterSizebracket);
    CREATE TEMPORARY TABLE TempAvgMarketSales AS
    SELECT 
        r.brand_id, 
        AVG(r.value_sales) AS avg_market_sales
    FROM 
        TempFilteredData r
    GROUP BY 
        r.brand_id;

    -- Step 2: Calculate the overall average market sales (denominator)
    SET @overall_avg_market_sales = (
        SELECT AVG(r.value_sales)
        FROM TempFilteredData r
    );

    -- Step 3: Update the brand table with the calculated brand_value_idx_avmv
    UPDATE brand b
    JOIN TempAvgMarketSales t ON b.brand_id = t.brand_id
    SET b.brand_value_idx_avmv = t.avg_market_sales / @overall_avg_market_sales;

    -- Step 4: Drop the temporary table to clean up
    DROP TEMPORARY TABLE IF EXISTS TempAvgMarketSales;
END $$
DELIMITER ;

drop PROCEDURE UpdateBrandValueIdxLY;
DELIMITER $$
CREATE PROCEDURE UpdateBrandValueIdxLY(
    IN InputYear YEAR,
    IN filterRegion VARCHAR(50),
    IN filterSegment VARCHAR(50),
    IN filterSku VARCHAR(50),
    IN filterBrand VARCHAR(50),
    IN filterSizebracket VARCHAR(50)
)
BEGIN
    -- Step 1: Prepare the filtered data
    CALL PrepareFilteredData(filterRegion, filterSegment, filterSku, filterBrand, filterSizebracket);

    -- Step 2: Create a temporary table to hold the calculated values
    CREATE TEMPORARY TABLE TempBrandValueIndex (
        brand_id INT,
        value_sales_last_year DECIMAL(10, 2),
        value_sales_this_year DECIMAL(10, 2),
        brand_value_idx_ly DECIMAL(10, 4)
    );

    -- Step 3: Insert data into TempBrandValueIndex from the filtered data
    INSERT INTO TempBrandValueIndex (brand_id, value_sales_last_year, value_sales_this_year, brand_value_idx_ly)
    SELECT 
        t.brand_id, 
        SUM(CASE WHEN YEAR(t.date) = InputYear - 1 THEN t.value_sales ELSE 0 END) AS value_sales_last_year,
        SUM(CASE WHEN YEAR(t.date) = InputYear THEN t.value_sales ELSE 0 END) AS value_sales_this_year,
        CASE WHEN SUM(CASE WHEN YEAR(t.date) = InputYear - 1 THEN t.value_sales ELSE 0 END) = 0 THEN NULL ELSE 
             SUM(CASE WHEN YEAR(t.date) = InputYear THEN t.value_sales ELSE 0 END) / 
             NULLIF(SUM(CASE WHEN YEAR(t.date) = InputYear - 1 THEN t.value_sales ELSE 0 END), 0) 
        END AS brand_value_idx_ly
    FROM TempFilteredData t
    GROUP BY t.brand_id;

    -- Step 4: Update the brand table with the calculated values
    UPDATE brand b
    JOIN TempBrandValueIndex t ON b.brand_id = t.brand_id
    SET b.value_sales_last_year = t.value_sales_last_year,
        b.value_sales_this_year = t.value_sales_this_year,
        b.brand_value_idx_ly = t.brand_value_idx_ly;
    
    -- Step 6: Drop the temporary tables to clean up
    DROP TEMPORARY TABLE IF EXISTS TempBrandValueIndex;
    DROP TEMPORARY TABLE IF EXISTS TempFilteredData;
END $$
DELIMITER ;


DELIMITER $$
create procedure rgm_index_for_brand ()
BEGIN
	drop TEMPORARY table if exists brand_shares;
    create TEMPORARY table brand_shares(
	select brand_id,
		case when volume_share = 0 Then 0
        else value_share/volume_share end  as rgm_index
	from (
	select brand_id,sum(value_sales)/(Select sum(value_sales) from rawdata) value_share
	,sum(volume_sales)/(Select sum(volume_sales) from rawdata) as volume_share
	From rawdata
	group by brand_id) shares);

update brand b
JOIN  brand_shares bs ON bs.brand_id = b.brand_id
SET b.rgm_index = bs.rgm_index;

DROP TEMPORARY TABLE IF EXISTS brand_shares;
End $$
DELIMITER ;


call UpdateBrandValueIdxAVMV(NULL,Null, NULL, NULL,NULL);
call UpdateBrandValueIdxLY(2023,NULL,Null, NULL, NULL,NULL);
call rgm_index();
select * from brand;



select * from rawdata;
