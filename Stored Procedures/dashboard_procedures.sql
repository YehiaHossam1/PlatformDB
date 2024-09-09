use platformdb1;

## adding the brand_value_idx_avmv to the brand table 
ALTER TABLE dashboard
ADD COLUMN brand_value_idx_avmv DECIMAL(10, 4);

## adding the brand_value_idx_ly to the brand table 
ALTER TABLE dashboard
ADD COLUMN brand_value_idx_ly DECIMAL(10, 4);


drop PROCEDURE if exists UpdateBrandValueIdxAVMV;
DELIMITER $$
CREATE PROCEDURE UpdateBrandValueIdxAVMV(
)
BEGIN
    -- Step 1: Create a temporary table to calculate average market sales for each brand
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
    UPDATE dashboard d
    JOIN TempAvgMarketSales t ON d.brand_id = t.brand_id
    SET d.brand_value_idx_avmv = t.avg_market_sales / @overall_avg_market_sales;
	
    -- Step 4: Drop the temporary table to clean up
    DROP TEMPORARY TABLE IF EXISTS TempAvgMarketSales;
END $$
DELIMITER ;

drop PROCEDURE UpdateBrandValueIdxLY;
DELIMITER $$
CREATE PROCEDURE UpdateBrandValueIdxLY(
    IN InputYear YEAR
)
BEGIN

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
    UPDATE dashboard d
    JOIN TempBrandValueIndex t ON d.brand_id = t.brand_id
    SET d.brand_value_idx_ly = t.brand_value_idx_ly;
    
    -- Step 6: Drop the temporary tables to clean up
    DROP TEMPORARY TABLE IF EXISTS TempBrandValueIndex;
END $$
DELIMITER ;


drop procedure if exists rgm_index;
DELIMITER $$
create procedure rgm_index(
)
BEGIN
	drop TEMPORARY table if exists brand_shares;
    
    create TEMPORARY table brand_shares(
	select brand_id,
		case when volume_share = 0 Then 0
        else value_share/volume_share end  as rgm_index
	from brand);

    
	insert into dashboard(brand_id,rgm_index)
	select brand_id,rgm_index from brand_shares
    ON DUPLICATE KEY UPDATE rgm_index = VALUES(rgm_index);

DROP TEMPORARY TABLE IF EXISTS brand_shares;
End $$
DELIMITER ;


drop procedure if exists UpdateTradevsBrandIndex;
DELIMITER $$
create procedure UpdateTradevsBrandIndex(
)
Begin	
    create temporary table tradevsbrandindex(
		select brand_id,volume_share/brand_fair_share as trade_vs_brand_idx
        from brand);
	
    update dashboard d 
    join tradevsbrandindex t on d.brand_id = t.brand_id
	set d.trade_vs_brand_idx = t.trade_vs_brand_idx;
    
    drop temporary table if exists tradevsbrandindex;
end $$
DELIMITER ;

drop procedure if exists updatePriceChangeIndex;
delimiter $$
create procedure updatePriceChangeIndex(
)
Begin 
	DECLARE market_change_index DECIMAL(18, 2);
    
    	-- Materialize the total value_sales from TempFilteredData into a variable
    SELECT sum(value_sales)/sum(volume_sales) INTO market_change_index FROM TempFilteredData;
    
        -- Create the BrandMarketshare temporary table
    CREATE TEMPORARY TABLE BrandPriceIndex AS
    SELECT 
        brand_id,
        case when sum(volume_sales) = 0 then 0
        Else (sum(value_sales)/sum(volume_sales)) / market_change_index end as price_change_idx
    FROM 
        TempFilteredData r
    GROUP BY 
        r.brand_id;
        
	-- Update the dashboard table with the calculated price Index
    UPDATE dashboard d
    JOIN BrandPriceIndex bpi ON d.brand_id = bpi.brand_id
    SET d.price_change_idx = bpi.price_change_idx;
    
	-- Clean up: Drop the temporary tables
    DROP TEMPORARY TABLE IF EXISTS BrandPriceIndex;
End $$
Delimiter ;


drop procedure if exists dashboard_values;
delimiter $$ 
create procedure dashboard_values(
    IN filterRegion VARCHAR(50),
    IN filterSegment VARCHAR(50),
    IN filterSku VARCHAR(50),
    IN filterBrand VARCHAR(50),
    IN filterSizebracket VARCHAR(50)
)
Begin 
    call brand_values(filterRegion,filterSegment,filterSku,filterBrand,filterSizebracket);
	call PrepareFilteredData(filterRegion, filterSegment, filterSku, filterBrand, filterSizebracket);
	call rgm_index();
	call UpdateBrandValueIdxAVMV();
	call UpdateBrandValueIdxLY(2023);
	call UpdateTradevsBrandIndex();
	call updatePriceChangeIndex();
	select * from dashboard;
    
    drop temporary table if exists PrepareFilteredData;
end $$
delimiter ;


call dashboard_values(Null,Null, Null, Null,Null);