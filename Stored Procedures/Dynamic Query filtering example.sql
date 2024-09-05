use platformdb1;

alter table brand 
add column value_sales_last_year decimal(10,2);

alter table brand 
add column value_sales_this_year decimal(10,2);


drop PROCEDURE CalculateBrandValueIndexLY;

DELIMITER $$
CREATE PROCEDURE CalculateBrandValueIndexLY(
    IN InputYear YEAR,
    IN filterRegion VARCHAR(50),
    IN filterCategory VARCHAR(50),
    IN filterSku VARCHAR(50),
    IN filterBrand VARCHAR(50),
    IN filterSizebracket VARCHAR(50)
)
BEGIN
    DECLARE baseQuery TEXT;
    DECLARE whereClause TEXT;
    
    -- Step 1: Create a temporary table to hold the calculated values
    CREATE TEMPORARY TABLE TempBrandValueIndex (
        brand_id INT,
        value_sales_last_year DECIMAL(10, 2),
        value_sales_this_year DECIMAL(10, 2),
        brand_value_idx_ly DECIMAL(10, 4)
    );

    -- Step 2: Build the base query for the calculation
    SET baseQuery = CONCAT(
        'INSERT INTO TempBrandValueIndex (brand_id, value_sales_last_year, value_sales_this_year, brand_value_idx_ly) ',
        'SELECT r.brand_id, ',
        'SUM(CASE WHEN YEAR(r.date) = ', InputYear, ' - 1 THEN r.value_sales ELSE 0 END) AS value_sales_last_year, ',
        'SUM(CASE WHEN YEAR(r.date) = ', InputYear, ' THEN r.value_sales ELSE 0 END) AS value_sales_this_year, ',
        'SUM(CASE WHEN YEAR(r.date) = ', InputYear, ' THEN r.value_sales ELSE 0 END) / ',
        'SUM(CASE WHEN YEAR(r.date) = ', InputYear, ' - 1 THEN r.value_sales ELSE 0 END) AS brand_value_idx_ly ',
        'FROM rawdata r ',
        'JOIN category c ON c.category_id = r.category_id ',
        'LEFT JOIN sku s ON s.sku_id = r.sku_id ',
        'LEFT JOIN Reigon rg ON rg.reigon_id = r.reigon_id ',
        'JOIN sizebracket sb ON sb.size_bracket_id = r.size_bracket_id ',
        'JOIN brand b ON b.brand_id = r.brand_id'
    );

    SET whereClause = ' WHERE 1=1 ';
    
    -- Step 3: Add filtering clauses dynamically
    IF filterRegion IS NOT NULL THEN
        SET whereClause = CONCAT(whereClause, ' AND rg.reigon_name = ''', filterRegion, '''');
    END IF;
    
    IF filterCategory IS NOT NULL THEN
        SET whereClause = CONCAT(whereClause, ' AND c.category_name = ''', filterCategory, '''');
    END IF;
    
    IF filterSku IS NOT NULL THEN
        SET whereClause = CONCAT(whereClause, ' AND s.sku_name = ''', filterSku, '''');
    END IF;
    
    IF filterBrand IS NOT NULL THEN
        SET whereClause = CONCAT(whereClause, ' AND b.brand_name = ''', filterBrand, '''');
    END IF;

    IF filterSizebracket IS NOT NULL THEN
        SET whereClause = CONCAT(whereClause, ' AND sb.size_bracket_name = ''', filterSizebracket, '''');
    END IF;
    
    -- Complete the subquery with GROUP BY
    SET baseQuery = CONCAT(baseQuery, whereClause, ' GROUP BY r.brand_id');
    
    -- Step 4: Execute the dynamic query to populate the temporary table
    SET @finalQuery = baseQuery;
    PREPARE stmt FROM @finalQuery;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
	
	-- Step 5: Debug: Inspect the contents of the temporary table
    SELECT * FROM TempBrandValueIndex;
    
    -- Step 5: Update the brand table with the calculated values
    UPDATE brand b
    JOIN TempBrandValueIndex t ON b.brand_id = t.brand_id
    SET b.value_sales_last_year = t.value_sales_last_year,
        b.value_sales_this_year = t.value_sales_this_year,
        b.brand_value_idx_ly = t.brand_value_idx_ly;
    
    -- Step 6: Drop the temporary table to clean up
    DROP TEMPORARY TABLE IF EXISTS TempBrandValueIndex;

END $$
DELIMITER ;

CALL CalculateBrandValueIndexLY(2023,NULL,Null, NULL, NULL,NULL);
CALL CalculateBrandValueIndexLY(2024,"SA TTL KSA","CANOLA OIL", NULL, NULL,NULL);

select * from brand;