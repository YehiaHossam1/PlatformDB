Use platformdb1;
DROP TABLE IF EXISTS SKU;

CREATE TABLE SKU (
    SKU_id INT AUTO_INCREMENT PRIMARY KEY,
    SKU_name VARCHAR(255) NOT NULL
);

-- Drop the foreign key constraint directly
-- ALTER TABLE RawData
-- DROP FOREIGN KEY category_fk_1;

-- drop the index 
-- ALTER TABLE Category
-- DROP INDEX Category;

CREATE INDEX SKU
ON SKU(SKU_id);