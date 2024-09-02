use platformdb1;

## adding the brand_value_idx_avmv to the brand table 
ALTER TABLE brand
ADD COLUMN brand_value_idx_avmv DECIMAL(10, 4);

## adding the brand_value_idx_ly to the brand table 
ALTER TABLE brand
ADD COLUMN brand_value_idx_ly DECIMAL(10, 4);

alter table brand 
add column rgm_index decimal(10,2);

DELIMITER $$
CREATE PROCEDURE UpdateBrandValueIdxAVMV()
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
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE UpdateBrandValueIdxLY()
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

call UpdateBrandValueIdxAVMV();
call UpdateBrandValueIdxLY();
call rgm_index()