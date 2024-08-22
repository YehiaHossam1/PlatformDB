Use platformdb1;
DROP TABLE IF EXISTS Reigon;

CREATE TABLE Reigon (
    reigon_id INT AUTO_INCREMENT PRIMARY KEY,
    reigon_name VARCHAR(255) NOT NULL
);

-- Drop the foreign key constraint directly
-- ALTER TABLE RawData
-- DROP FOREIGN KEY category_fk_1;

-- drop the index 
-- ALTER TABLE Reigon
-- DROP INDEX Reigon;

CREATE INDEX Reigon
ON Reigon(reigon_id);