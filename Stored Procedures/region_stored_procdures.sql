use platformdb1;

-- adding the actual_sales_growth to the Reigon table 
ALTER TABLE Reigon
ADD COLUMN market_share DECIMAL(10, 4);

-- adding the actual_sales_growth to the Reigon table 
ALTER TABLE Reigon
ADD COLUMN actual_sales_growth DECIMAL(10, 4);

drop PROCEDURE if exists UpdateRegionSalesGrowth;

DELIMITER $$
CREATE PROCEDURE UpdateRegionSalesGrowth()
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
END $$
DELIMITER ;


drop PROCEDURE if exists UpdateMarketShare;
DELIMITER $$
CREATE PROCEDURE UpdateMarketShare()
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
end $$
DELIMITER ;


