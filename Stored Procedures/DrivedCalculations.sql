use platformdb1;

DELIMITER $$
CREATE PROCEDURE CalcualteValueVolumeShare()
BEGIN
	INSERT INTO DerivedCalculations (brand_id,rawdata_id, value_share, volume_share)
	SELECT
		r.brand_id,
		r.id, -- Assuming there's an id column in RAWDATA
		r.value_sales / SUM(r.value_sales) OVER (),  -- Calculating value_share
		r.volume_sales / SUM(r.volume_sales) OVER () -- Calculating volume_share
	FROM
		RAWDATA r;
END $$
DELIMITER ;

call CalcualteValueVolumeShare();

