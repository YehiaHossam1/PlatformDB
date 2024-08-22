Use platformdb1;
DROP TABLE IF EXISTS Dates;

CREATE TABLE Dates (
    date_id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE,
    year INT,
    month INT,
    quarter INT
);

-- Drop the foreign key constraint directly
-- ALTER TABLE RawData
-- DROP FOREIGN KEY category_fk_1;

-- drop the index 
-- ALTER TABLE Dates
-- DROP INDEX Dates;

CREATE INDEX Dates
ON Dates(date_id);

DELIMITER $$

CREATE TRIGGER before_insert_dim_date 
BEFORE INSERT ON Dates
FOR EACH ROW
BEGIN
    SET NEW.year = YEAR(NEW.date);
    SET NEW.month = MONTH(NEW.date);
    SET NEW.quarter = QUARTER(NEW.date);
END$$

DELIMITER ;

Truncate table dates;
