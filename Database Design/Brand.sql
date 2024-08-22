Use platformdb1;
DROP TABLE IF EXISTS Brand;

CREATE TABLE Brand (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(255) NOT NULL
);

-- Drop the foreign key constraint directly
-- ALTER TABLE RawData
-- DROP FOREIGN KEY category_fk_1;

-- drop the index 
-- ALTER TABLE Brand
-- DROP INDEX Brand;

CREATE INDEX Brand
ON Brand(brand_id);