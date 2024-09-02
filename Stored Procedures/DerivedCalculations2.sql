use platformdb1;

alter table derivedcalculations
add column market_id int;

drop PROCEDURE CalculateDerivedColumns;

DELIMITER $$
CREATE PROCEDURE CalculateDerivedColumns(IN groupByField VARCHAR(50))
BEGIN
    -- Declare a variable to hold the dynamic SQL query
    DECLARE sqlQuery TEXT;
    
    -- Declare a variable to hold the grouping field
    DECLARE groupField VARCHAR(50);

    -- Determine which field to group by based on the input parameter
    CASE groupByField
        WHEN 'category' THEN 
            SET groupField = 'category_id';
        WHEN 'brand' THEN 
            SET groupField = 'brand_id';
        WHEN 'sku' THEN 
            SET groupField = 'sku_id';
        WHEN 'reigon' THEN 
            SET groupField = 'reigon_id';
        WHEN 'size_bracket' THEN 
            SET groupField = 'size_bracket_id';
        ELSE 
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid groupByField value. Must be one of category, brand, sku, reigon, or size_bracket';
    END CASE;
    
    -- Truncate the derivedcalculations table
    TRUNCATE TABLE derivedcalculations;

    -- Build the dynamic SQL query to calculate value_share and insert into derivedcalculations
    SET sqlQuery = CONCAT(
        'INSERT INTO derivedcalculations (rawdata_id,market_id, value_share, volume_share) ',
        'SELECT ANY_VALUE(r.id) as rawdata_id, r.', groupField, ' AS market_id, ',
        'SUM(r.value_sales) / (SELECT SUM(value_sales) FROM rawdata) AS value_share, ',
        'SUM(r.volume_sales) / (SELECT SUM(volume_sales) FROM rawdata) AS volume_share ',
        'FROM rawdata r ',
        'GROUP BY r.', groupField
    );

    -- Prepare and execute the dynamic SQL query
    SET @sqlQuery = sqlQuery;  -- Assign the constructed query to a session variable
    PREPARE stmt FROM @sqlQuery;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
END $$

DELIMITER ;


CALL CalculateDerivedColumns('size_bracket');
select * from derivedcalculations;
