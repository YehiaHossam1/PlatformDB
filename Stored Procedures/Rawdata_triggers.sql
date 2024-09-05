use platformdb1;

ALTER TABLE rawdata ADD COLUMN value_sales_iya DECIMAL(10, 4) NULL;
ALTER TABLE rawdata ADD COLUMN volume_sales_iya DECIMAL(10, 4) NULL;

drop trigger if exists calculate_value_sales_iya;

DELIMITER $$

CREATE TRIGGER calculate_value_sales_iya
BEFORE INSERT ON rawdata
FOR EACH ROW
BEGIN
    DECLARE last_year_value_sales DECIMAL(10, 2);
    
    -- Fetch the last year's value_sales for the same product, brand, segment, and month
    SELECT r2.value_sales
    INTO last_year_value_sales
    FROM rawdata r2
    WHERE r2.size_bracket_id = NEW.size_bracket_id
    AND r2.brand_id = NEW.brand_id
    AND r2.segment_id = NEW.segment_id
	AND COALESCE(r2.sku_id, '') = COALESCE(NEW.sku_id, '')
    AND COALESCE(r2.reigon_id, '') = COALESCE(NEW.reigon_id, '')
    AND YEAR(r2.date) = YEAR(NEW.date) - 1
    AND MONTH(r2.date) = MONTH(NEW.date)
    LIMIT 1;
    
    -- Calculate the value_sales_iya and assign it to the NEW row
    IF last_year_value_sales IS NULL THEN
        SET NEW.value_sales_iya = NULL;
    ELSEIF last_year_value_sales = 0 THEN
        SET NEW.value_sales_iya = 0;
    ELSE
        SET NEW.value_sales_iya = NEW.value_sales / last_year_value_sales;
    END IF;
END $$

DELIMITER ;


drop trigger if exists calculate_volume_sales_iya;
DELIMITER $$

CREATE TRIGGER calculate_volume_sales_iya
BEFORE INSERT ON rawdata
FOR EACH ROW
BEGIN
    DECLARE last_year_volume_sales DECIMAL(10, 2);
    
    -- Fetch the last year's value_sales for the same product, brand, segment, and month
    SELECT r2.volume_sales
    INTO last_year_volume_sales
    FROM rawdata r2
    WHERE r2.size_bracket_id = NEW.size_bracket_id
    AND r2.brand_id = NEW.brand_id
    AND r2.segment_id = NEW.segment_id
	AND COALESCE(r2.sku_id, '') = COALESCE(NEW.sku_id, '')
    AND COALESCE(r2.reigon_id, '') = COALESCE(NEW.reigon_id, '')
    AND YEAR(r2.date) = YEAR(NEW.date) - 1
    AND MONTH(r2.date) = MONTH(NEW.date)
    LIMIT 1;
    
    -- Calculate the value_sales_iya and assign it to the NEW row
    IF last_year_volume_sales IS NULL THEN
        SET NEW.volume_sales_iya = NULL;
    ELSEIF last_year_volume_sales = 0 THEN
        SET NEW.volume_sales_iya = 0;
    ELSE
        SET NEW.volume_sales_iya = NEW.volume_sales / last_year_volume_sales;
    END IF;
END $$

DELIMITER ;

select * from rawdata
order by brand_id,segment_id,size_bracket_id,date;
