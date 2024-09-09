use platformdb1;

drop procedure if exists PrepareFilteredData;

DELIMITER $$
CREATE PROCEDURE PrepareFilteredData(
    IN filterRegion VARCHAR(50),
    IN filterSegment VARCHAR(50),
    IN filterSku VARCHAR(50),
    IN filterBrand VARCHAR(50),
    IN filterSizebracket VARCHAR(50)
)
BEGIN
    -- Step 1: Drop the temporary table if it already exists
    DROP TEMPORARY TABLE IF EXISTS TempFilteredData;

    -- Step 2: Create a temporary table with all the necessary joins and filters applied
    CREATE TEMPORARY TABLE TempFilteredData AS
    SELECT
		r.date,
        r.brand_id,
        r.segment_id,
        r.sku_id,
        r.reigon_id,
        r.size_bracket_id,
        r.value_sales,
        r.volume_sales,
        sg.segment_name,
        s.sku_name,
        rg.reigon_name,
        sb.size_bracket_name,
        b.brand_name
    FROM rawdata r
    LEFT JOIN Segment sg ON sg.segment_id = r.segment_id
    LEFT JOIN sku s ON s.sku_id = r.sku_id
    LEFT JOIN Reigon rg ON rg.reigon_id = r.reigon_id
    LEFT JOIN sizebracket sb ON sb.size_bracket_id = r.size_bracket_id
    LEFT JOIN brand b ON b.brand_id = r.brand_id
    WHERE 1=1
    AND (filterRegion IS NULL OR rg.reigon_name = filterRegion)
    AND (filterSegment IS NULL OR sg.Segment_name = filterSegment)
    AND (filterSku IS NULL OR s.sku_name = filterSku)
    AND (filterBrand IS NULL OR b.brand_name = filterBrand)
    AND (filterSizebracket IS NULL OR sb.size_bracket_name = filterSizebracket);

END $$
DELIMITER ;

# Filter by reigon,segment,sku,brand,size_bracket
call PrepareFilteredData(Null, Null, Null, Null, Null);
