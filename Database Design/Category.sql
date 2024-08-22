Use platformdb1;
DROP TABLE IF EXISTS Category;

CREATE TABLE Category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL
);


-- drop the index 
-- ALTER TABLE Category
-- DROP INDEX Category;

CREATE INDEX Category
ON Category(category_id);

-- ALTER TABLE rawdata DROP FOREIGN KEY rawdata_ibfk_4;
-- TRUNCATE TABLE Category;
-- ALTER TABLE rawdata ADD CONSTRAINT rawdata_ibfk_4 FOREIGN KEY (category_id) REFERENCES Category(Category_id);
