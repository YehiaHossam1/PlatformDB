use platformdb1;

drop PROCEDURE CalculateBrandValueIndexLY;

DELIMITER $$
CREATE PROCEDURE CalculateBrandValueIndexLY(
	IN InputYear YEAR,
    IN filterRegion varchar(50),
    IN filterCategory varchar(50),
    IN filterSku varchar(50),
    IN filterBrand varchar(50),
    IN filterSizebracket varchar(50)
)
BEGIN
    DECLARE baseQuery TEXT;
    DECLARE whereClause TEXT;
    
    SET baseQuery = CONCAT('SELECT b.brand_name, SUM(CASE WHEN year(date) = ',InputYear,' - 1 THEN value_sales ELSE 0 END) as value_sales_last_year,
							SUM(CASE WHEN year(date) = ',InputYear,' THEN value_sales ELSE 0 END) as value_sales_this_year,
                            SUM(CASE WHEN year(date) = ',InputYear,' THEN value_sales ELSE 0 END)/
                            SUM(CASE WHEN year(date) = ',InputYear,' - 1 THEN value_sales ELSE 0 END) AS brand_value_idx_ly
                     FROM rawdata r 
                     JOIN category c ON c.category_id = r.category_id
                     JOIN sku s ON s.sku_id = r.sku_id
                     JOIN Reigon rg ON rg.reigon_id = r.reigon_id
                     JOIN sizebracket sb ON sb.size_bracket_id = r.size_bracket_id
                     JOIN brand b on b.brand_id = r.brand_id');
                     
    SET whereClause = ' WHERE 1=1 ';
    
    -- Add filtering clauses dynamically
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
        SET whereClause = CONCAT(whereClause, ' AND sb.brand_name = ''', filterBrand, '''');
    END IF;
    
    -- Complete the query with GROUP BY
    SET baseQuery = CONCAT(baseQuery, whereClause, ' GROUP BY b.brand_id');
    
    -- Execute the dynamic query
    SET @finalQuery = baseQuery;
    PREPARE stmt FROM @finalQuery;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;    
END $$
DELIMITER ;

CALL CalculateBrandValueIndexLY(2024,NULL,NULL, NULL, NULL,NULL);
CALL CalculateBrandValueIndexLY(2024,"SA TTL KSA","CANOLA OIL", NULL, NULL,NULL);

