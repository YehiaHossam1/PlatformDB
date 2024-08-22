CREATE TABLE DerivedCalculations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    brand_id INT,
    rawdata_id INT,
    value_share DECIMAL(10, 4),
    volume_share DECIMAL(10, 4),
    FOREIGN KEY (rawdata_id) REFERENCES RAWDATA(id), -- Assuming there's an id column in RAWDATA
	FOREIGN KEY (brand_id) REFERENCES brand(brand_id)
);

INSERT INTO DerivedCalculations (brand_id,rawdata_id, value_share, volume_share)
SELECT
	r.brand_id,
    r.id, -- Assuming there's an id column in RAWDATA
    r.value_sales / SUM(r.value_sales) OVER (),  -- Calculating value_share
    r.volume_sales / SUM(r.volume_sales) OVER () -- Calculating volume_share
FROM
    RAWDATA r;
-- join
-- 	brand b  on b.brand_id = r.brand_id;

ALTER TABLE DerivedCalculations DROP FOREIGN KEY derivedcalculations_ibfk_1;
ALTER TABLE DerivedCalculations DROP FOREIGN KEY derivedcalculations_ibfk_2;

-- TRUNCATE TABLE DerivedCalculations;
ALTER TABLE DerivedCalculations ADD CONSTRAINT derivedcalculations_ibfk_1 FOREIGN KEY (rawdata_id) REFERENCES  RAWDATA(id);

-- alter table DerivedCalculations add column brand_id INT;
ALTER TABLE DerivedCalculations ADD CONSTRAINT derivedcalculations_ibfk_2 FOREIGN KEY (brand_id) REFERENCES  brand(brand_id);
truncate table DerivedCalculations;





